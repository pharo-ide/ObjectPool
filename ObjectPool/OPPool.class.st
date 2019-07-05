"
I am general and abstract pool for objects. Objects are borrowed from pool using #borrow and returned to pool using #return:. There
is convience method #withPooled: to run one argument block with pooled object. To create minimal usable pool one can make subclass and
override #makeObject method. See OPBasicPool for more usable implementation. 

Pooled objects have general lifecycle. Subclasses can perform needed operations on these lifecycle steps.
Life cycle and corresponding methods are following:

1. Object is created. (#makeObject)
		This occurs for example when there is not enough objects to be borrowd and there is room in the pool.
		
2. Object is activated. (#activateObject:)
		This happens to all objects that have been previously passivated when they are borrowed.
				
4. Object is passivated. (#passivateObject:)
		This happens when object is returned to the pool.
		
5. Object is destroyed. (#destroyObject:)
		This happens when object is no longer usable (any lifecycle operation fails) or pool is shrinked.

In addition to this lifecycle there are ""event"" handling methods: #objectGoingToBeBorrowed:, #objectGoingToBeReturned:.
These methods can be used to veto object borrowing or returning by throwing OPAbortOperation. Aborting return 
prevents object getting back to idleObjects set. Preventing borrow causes pool to try borrowing again. In both
cases the object is destroyed using #destroyObject:.
		
Instance Variables:
	lock            		<Monitor>		Monitor used to synchronize object.
	idleObjects 		<IdentitySet>			Objects that currenlty idle. Idle objects are in passive state.
	borrowedObjects	<IdentitySet>			Objects that have been lended outside of the pool.

"
Class {
	#name : #OPPool,
	#superclass : #Object,
	#instVars : [
		'lock',
		'borrowedObjects',
		'idleObjects'
	],
	#category : 'ObjectPool'
}

{ #category : #'object-lifecycle' }
OPPool >> activateObject: anObject [
	"Activates previously passivated object"

	
]

{ #category : #pooling }
OPPool >> addObject [ 
	"Creates object, then passivates it and adds to pool."
	self objectToPool: self makeObject.  
]

{ #category : #pooling }
OPPool >> borrow [
	"Returns activated object from pool or creates new pooled object and returns it."

	| object |
	[ object := self unsafeBorrow.
	self objectGoingToBeBorrowed: object]
		on: OPAbortOperation
		do: [ :e | 
			self critical: [borrowedObjects remove: object].
			self destroyObject: object.
			e retry ].
	^ object
]

{ #category : #pooling }
OPPool >> clear [
	"Removes all objects from the pool and reinitializes it.
	Method will run the destroyer for every pooled objects."

	| oldObjects |
	lock
		critical: [ 
			oldObjects :=  IdentitySet withAll: idleObjects.
			idleObjects removeAll ].
	oldObjects do: [ :o | self destroyObject: o ]
]

{ #category : #synchronizing }
OPPool >> critical: aBlock [
	^lock critical: aBlock.
]

{ #category : #synchronizing }
OPPool >> currentMilliseconds [
	^Time primMillisecondClock.
]

{ #category : #'object-lifecycle' }
OPPool >> destroyObject: anObject [
	"Destroys an object"

	
]

{ #category : #initialization }
OPPool >> initPool [
	idleObjects := IdentitySet new.
	borrowedObjects := IdentitySet new.
	lock := Monitor new.

]

{ #category : #initialization }
OPPool >> initialize [
	super initialize.
	self initPool.
]

{ #category : #testing }
OPPool >> isEmpty [

	^idleObjects isEmpty & borrowedObjects isEmpty
]

{ #category : #testing }
OPPool >> isPooled: anObject [
	"Returns true if given object is pooled in this pool. Returns false otherwise.
	Method does not depend on whether object is currently borrowed or not.
	"

	lock critical: [ ^ (borrowedObjects includes: anObject) or: [idleObjects includes: anObject] ].
]

{ #category : #'object-lifecycle' }
OPPool >> makeObject [
	"Creates new object in activated state."
	self subclassResponsibility.
	
]

{ #category : #testing }
OPPool >> numberOfActiveObjects [
	^self critical: [borrowedObjects size].
]

{ #category : #testing }
OPPool >> numberOfAvailableObjects [
	^self critical: [borrowedObjects size + idleObjects size].
]

{ #category : #testing }
OPPool >> numberOfIdleObjects [
	^self critical: [idleObjects size].
]

{ #category : #private }
OPPool >> objectFromPool [
	"Return an activated object from pool. Should not be called if there are no
	free objects in the pool."

	| object |
	self critical: [ object := idleObjects remove: idleObjects anyOne ].
	self activateObject: object.
	^ object
]

{ #category : #private }
OPPool >> objectFromPoolOrElse: notAvailableBlock [
	"Returns activated object from queue or runs given block."

	^idleObjects 
		ifEmpty: notAvailableBlock 
		ifNotEmpty: [ self objectFromPool ]
]

{ #category : #events }
OPPool >> objectGoingToBeBorrowed: anObject [

]

{ #category : #events }
OPPool >> objectGoingToBeReturned: anObject [
]

{ #category : #private }
OPPool >> objectToPool: anObject [
	"Puts object back to pool"
	self passivateObject: anObject.
	self
		critical: [ 
			idleObjects add: anObject.
			self signalIdleAvailable ]
]

{ #category : #'object-lifecycle' }
OPPool >> passivateObject: anObject [
	"Passivates an activated object"
]

{ #category : #pooling }
OPPool >> return: anObject [
	"Returns previously borrowed object from the pool. If object is not from this pool then
	ObjectPoolWrongPoolError is raised."

	self critical: [ 
		(borrowedObjects includes: anObject)
			ifFalse: [ OPWrongPoolError signal: 'Object is not from this pool instance.' ]].
	
	[self objectGoingToBeReturned: anObject] on: OPAbortOperation do: [ 
		^self destroyObject: anObject].
	
	self critical: [
		borrowedObjects remove: anObject.
		self objectToPool: anObject]
]

{ #category : #private }
OPPool >> signalIdleAvailable [
	lock signal
]

{ #category : #private }
OPPool >> unsafeBorrow [
	| object |
	object := self objectFromPoolOrElse: [ self makeObject ].
	self critical: [borrowedObjects add: object].
	^object
]

{ #category : #synchronizing }
OPPool >> waitUntil: aBlock [
"Waits signal on synchronization lock until given block evaluates true."
	lock waitUntil: aBlock.  
]

{ #category : #synchronizing }
OPPool >> waitUntil: aBlock timoutAfterMilliseconds: aNumber [
"Waits signal on synchronization lock until aBlock evaluates true or more than
given milliseconds have passed then OPTimedOutError is signaled."
	| startTime |
	startTime := self currentMilliseconds.
	lock
		waitUntil: [ 
			self currentMilliseconds - startTime > aNumber
				ifTrue: [ OPTimedOutError signal ].
			aBlock value.]
		maxMilliseconds: aNumber
]

{ #category : #pooling }
OPPool >> withPooled: oneArgumentBlock [
	"Runs given block with object from the pool."
	| o |
	o := self borrow.
	^[oneArgumentBlock cull: o ] ensure: [ self return: o ]
]
