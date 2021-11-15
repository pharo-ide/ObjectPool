"
I add some usable features to the general object pool.
- validation
- max and min sizes for idle objects.

Things to do:
- max size for borrowed objects.
- max time to wait for object.
- possibility to set if validation occurs before borrow, after return or while idle.
- background idle checking.
- time tracking for idle time.
- time tracking for borrow time. (maybe)
"
Class {
	#name : #OPBasicPool,
	#superclass : #OPPool,
	#instVars : [
		'creator',
		'passivator',
		'activator',
		'destroyer',
		'validator',
		'minIdleObjects',
		'maxIdleObjects',
		'maxActiveObjects',
		'maxWaitForBorrow'
	],
	#category : 'ObjectPool'
}

{ #category : #'object-lifecycle' }
OPBasicPool >> activateObject: anObject [
	activator isNil ifFalse:[activator value: anObject].
	^anObject.
]

{ #category : #'pool configuration' }
OPBasicPool >> activator [
	^activator
]

{ #category : #'pool configuration' }
OPBasicPool >> activator: aBlockClosure [ 
	activator := aBlockClosure.
]

{ #category : #'pool configuration' }
OPBasicPool >> clear [
	super clear.
	self ensureMinimumIdleObjects.
]

{ #category : #'pool configuration' }
OPBasicPool >> creator [
	^creator.
]

{ #category : #'pool configuration' }
OPBasicPool >> creator: aBlockClosure [ 
	"Sets the block that handles creation of new objects."
	creator := aBlockClosure.
]

{ #category : #'object-lifecycle' }
OPBasicPool >> destroyObject: anObject [
	destroyer isNil ifFalse:[destroyer value: anObject].
]

{ #category : #'pool configuration' }
OPBasicPool >> destroyer [
	^destroyer
]

{ #category : #'pool configuration' }
OPBasicPool >> destroyer: aBlockClosure [
	destroyer := aBlockClosure.
]

{ #category : #pooling }
OPBasicPool >> ensureMinimumIdleObjects [
	self critical: [ self whileNotEnoughIdleObjects: [ self addObject ] ]
]

{ #category : #pooling }
OPBasicPool >> fixMaxActiveObjects [

	self critical: [maxActiveObjects := self numberOfAvailableObjects].
]

{ #category : #pooling }
OPBasicPool >> hasEnoughIdleObjects [
	^ minIdleObjects ifNil: [ true ] ifNotNil: [ idleObjects size >= minIdleObjects ]
]

{ #category : #events }
OPBasicPool >> ifFull: aBlock [
	 ^(self isFull) ifTrue:aBlock.
]

{ #category : #pooling }
OPBasicPool >> ifNotEnoughIdleObjects: aBlock [
	^ self hasEnoughIdleObjects ifTrue: aBlock
]

{ #category : #events }
OPBasicPool >> isFull [
	^ maxIdleObjects ifNil: [ false ] ifNotNil: [ idleObjects size >= maxIdleObjects ]
]

{ #category : #'object-lifecycle' }
OPBasicPool >> makeObject [
	creator ifNil: [ self error: 'Creator should not be nil' ].
	^creator value.
]

{ #category : #'pool configuration' }
OPBasicPool >> maxActiveObjects [
	^maxActiveObjects
]

{ #category : #'pool configuration' }
OPBasicPool >> maxActiveObjects: aNumber [ 
	maxActiveObjects := aNumber.
]

{ #category : #'pool configuration' }
OPBasicPool >> maxIdleObjects: anInteger [ 
"Sets the limit for maximum idle objects stored in this pool."
	maxIdleObjects := anInteger.
]

{ #category : #'pool configuration' }
OPBasicPool >> maxWaitForBorrow: aNumber [
	"Sets milliseconds to wait for borrow to return an object."
	maxWaitForBorrow := aNumber.
]

{ #category : #pooling }
OPBasicPool >> migrateObjectsInto: anotherPool andDo: aBlock [

	self critical: [ 
		borrowedObjects ifNotEmpty: [ self error: 'Pool allow migration only when all objects are free' ].
		
		idleObjects do: [ :each | 
			anotherPool objectToPool: each.
			aBlock value: each].
		anotherPool fixMaxActiveObjects.
		idleObjects removeAll]
]

{ #category : #'pool configuration' }
OPBasicPool >> minIdleObjects: anInteger [
"
Sets the minimum amount of idle objects that are tried to keep on this pool.
Method also creates more idle objects if there are not enough them at the moment.
"
	minIdleObjects := anInteger.
	self ensureMinimumIdleObjects.
]

{ #category : #events }
OPBasicPool >> objectGoingToBeBorrowed: anObject [
	(self validateObject: anObject) ifFalse: [OPAbortOperation signal]
]

{ #category : #events }
OPBasicPool >> objectGoingToBeReturned: anObject [
	self ifFull:[OPAbortOperation signal].
]

{ #category : #'object-lifecycle' }
OPBasicPool >> passivateObject: anObject [
	passivator isNil ifFalse: [ passivator value: anObject ].
]

{ #category : #'pool configuration' }
OPBasicPool >> passivator [
	^passivator ifNil:[ [:object|] ]. 
]

{ #category : #'pool configuration' }
OPBasicPool >> passivator: aBlockClosure [
	"Sets block that is called to returned object."
	passivator:=aBlockClosure.
]

{ #category : #pooling }
OPBasicPool >> unsafeBorrow [
	| newObject |
	self critical: [ 
		maxActiveObjects ifNotNil: [ 
			maxWaitForBorrow
				ifNil: [ self waitUntil: [ self numberOfActiveObjects < maxActiveObjects ] ]
				ifNotNil: [ self waitUntil: [ self numberOfActiveObjects < maxActiveObjects ] timeoutAfterMilliseconds: maxWaitForBorrow ]].
		idleObjects ifNotEmpty: [ 
			^ borrowedObjects add: self objectFromPool ]	].
	newObject := self makeObject.
	self critical: [borrowedObjects add: newObject].
	^newObject
]

{ #category : #'object-lifecycle' }
OPBasicPool >> validateObject: anObject [
	^ validator ifNil: [ true ] ifNotNil: [ validator value: anObject ]
]

{ #category : #'pool configuration' }
OPBasicPool >> validator [
	^validator
]

{ #category : #'pool configuration' }
OPBasicPool >> validator: aBlockClosure [
	validator:=aBlockClosure.
]

{ #category : #pooling }
OPBasicPool >> whileNotEnoughIdleObjects: aBlock [
	^ [self hasEnoughIdleObjects] whileFalse: aBlock.
]
