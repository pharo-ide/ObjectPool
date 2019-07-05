"
ObjectPoolTest tests the working of ObjectPool.
"
Class {
	#name : #OPBasicPoolTest,
	#superclass : #OPPoolTestCase,
	#category : 'ObjectPool-Tests'
}

{ #category : #running }
OPBasicPoolTest >> poolClass [
	 ^OPBasicPool.
]

{ #category : #tests }
OPBasicPoolTest >> testAlteringObjectIsOK [
	| object |
	pool creator: [Array new: 1].
	object := pool borrow.
	object at: 1 put: 66.
	pool return: object.
	
	
]

{ #category : #tests }
OPBasicPoolTest >> testDoubleReturnIsNotPossible [
	| expected called |
	called := false.
	pool creator: [ Object new ].
	expected := pool borrow.
	pool passivator: [:o|called :=true. self should: [o=expected].].
	pool return: expected.
	self should: [pool return: expected] raise: Exception.
	self should: called.
]

{ #category : #tests }
OPBasicPoolTest >> testErrorInPassivatorIsNotEated [

	pool creator: [Object new].
	pool passivator:[:o|Error signal].
	self should: [pool return: pool borrow] raise: Error.

]

{ #category : #tests }
OPBasicPoolTest >> testFixMaxActiveObjects [

	pool creator: [ Object new ].
	pool maxActiveObjects: nil.
	self
		borrowOne;
		borrowOne.
	pool objectToPool: Object new.
	pool fixMaxActiveObjects.
	
	self assert: pool maxActiveObjects = 3
]

{ #category : #tests }
OPBasicPoolTest >> testIsPooledWorks [
	| expected|

	expected := Object new.
	pool creator: [Object new].
	self should: [pool isPooled: pool borrow].

]

{ #category : #tests }
OPBasicPoolTest >> testMaxActiveObjects [
	"Test that new objects can be returned only after there is room in active objects"

	| runTime semaphore |
	semaphore := Semaphore new.
	pool creator: [ Object new ].
	pool maxActiveObjects: 2.
	self
		borrowOne;
		borrowOne.
	[ 
	semaphore signal.
	0.1 seconds asDelay wait.
	self returnOne ] fork.
	semaphore wait.
	runTime := [ self borrowOne ] timeToRun.
	self should: runTime > 75 milliSeconds
]

{ #category : #tests }
OPBasicPoolTest >> testMaxActiveObjectsOneDoesNotBlockFirstBorrow [
	"Test that 1 maxActieObjects can return one object"
	pool creator: [ Object new ].
	pool maxActiveObjects: 1.
	self should: [self borrowOne] notTakeMoreThan: 0.1 seconds asDuration.
]

{ #category : #tests }
OPBasicPoolTest >> testMaxIdleObjects [
	pool creator: [Object new].
	pool maxIdleObjects: 2.
	self borrowOne;borrowOne;returnOne;returnOne.
	self should: 2 = pool numberOfIdleObjects.
	self borrowOne;borrowOne;borrowOne;returnOne;returnOne;returnOne.
	self should: 2 = pool numberOfIdleObjects.

]

{ #category : #tests }
OPBasicPoolTest >> testMaxWaitForBorrow [
	"Test that borrow operation throws OPTimedOutError"

	pool creator: [ Object new ].
	pool maxActiveObjects: 1.
	pool maxWaitForBorrow: 50.
	self
		should: [ 
			self borrowOne.
			self should: [ self borrowOne ] raise: OPTimedOutError ]
		notTakeMoreThan: 0.2 seconds asDuration
]

{ #category : #tests }
OPBasicPoolTest >> testMaxWaitForBorrowDoesNotAffectIfActiveCountIsNotReached [
	pool creator: [ Object new ].
	pool maxWaitForBorrow: 75.
	self should:[self
		borrowOne;
		borrowOne] notTakeMoreThan: 0.1 seconds asDuration.
]

{ #category : #tests }
OPBasicPoolTest >> testMigrationObjectsToAnotherPool [

	| anotherPool migrated |
	pool objectToPool: #object1.
	pool objectToPool: #object2.
	
	migrated := OrderedCollection new.
	anotherPool := self poolClass new.
	
	pool migrateObjectsInto: anotherPool andDo: [:each | migrated add: each ].
	
	self assert: {anotherPool borrow. anotherPool borrow} asSet equals: #(#object1 #object2) asSet.
	
	self assert: anotherPool numberOfAvailableObjects = 2.
	self assert: pool numberOfAvailableObjects = 0.
	self assert: migrated asSet equals: #(#object1 object2) asSet
]

{ #category : #tests }
OPBasicPoolTest >> testMigrationObjectsToAnotherPoolWhenBorrowedObjectsExists [

	| anotherPool |
	pool objectToPool: #object1.
	pool objectToPool: #object2.
	pool borrow.
	
	anotherPool := self poolClass new.
	
	[pool migrateObjectsInto: anotherPool andDo: nil.
	self assert: false description: 'should raise error'
	] ifError: [].
		
	self assert: anotherPool numberOfAvailableObjects = 0.
	self assert: pool numberOfAvailableObjects = 2
]

{ #category : #tests }
OPBasicPoolTest >> testMigrationObjectsToAnotherPoolWhichHasMaxObjectsLimit [

	| anotherPool |
	pool objectToPool: #object1.
	pool objectToPool: #object2.
	
	anotherPool := self poolClass new.
	anotherPool maxActiveObjects: 1.
	
	pool migrateObjectsInto: anotherPool andDo: [:each | ].
	
	self assert: {anotherPool borrow. anotherPool borrow} asSet equals: #(#object1 #object2) asSet.
	
	self assert: anotherPool numberOfAvailableObjects = 2.
	self assert: anotherPool maxActiveObjects = 2
]

{ #category : #tests }
OPBasicPoolTest >> testMinIdleObjects [

	pool creator: [Object new].
	pool minIdleObjects: 5.
	self should: 5 = pool numberOfIdleObjects.
	pool creator: [self fail]. "We should have 5 idle objects so creator should not be called."
	5 timesRepeat: [pool borrow].

]

{ #category : #tests }
OPBasicPoolTest >> testMinIdleObjectsAfterClear [

	pool creator: [Object new].
	pool minIdleObjects: 5.
	pool clear.
	self should: 5 = pool numberOfIdleObjects.
]

{ #category : #tests }
OPBasicPoolTest >> testMinSizeForIdleObjectsAfterClear [

	pool creator: [Object new].
	pool minIdleObjects: 5.
	pool clear.
	self should: 5 = pool numberOfIdleObjects.
]

{ #category : #tests }
OPBasicPoolTest >> testNewObjectsAreNotActivatedWhenBorrowed [
	| expected |
	
	pool creator: [ValueHolder new contents:'p'].
	pool activator:[:o | o contents:'a'].
	expected := pool borrow.
	self should: [expected contents = 'p'].

]

{ #category : #tests }
OPBasicPoolTest >> testNonValidObjectsAreDestroyed [
	| called count objects|
	objects := OrderedCollection new.
	called := false.
	count := 0.
	pool creator: [objects add: Object new].
	pool return: pool borrow.
	pool validator: [:o|count := count + 1. count > 1. ].
	pool destroyer: [:o|called := true].
	pool borrow.
	self should: called.
	self shouldnt: [pool isPooled: objects first].
	self should: [pool isPooled: objects second].
]

{ #category : #tests }
OPBasicPoolTest >> testNumberOfAvailableObjects [

	pool creator: [ Object new ].
	pool maxActiveObjects: nil.
	self
		borrowOne;
		borrowOne.
	pool objectToPool: Object new.
		
	self assert: pool numberOfAvailableObjects = 3
]

{ #category : #tests }
OPBasicPoolTest >> testObjectCanBeReturned [
	| expected called |

	called := false.
	pool creator: [Object new].
	expected := pool borrow.
	pool passivator: [:o|called :=true. self should: [o=expected].].
	pool return: expected.
	self should: called.
]

{ #category : #tests }
OPBasicPoolTest >> testObjectIsCreated [
	| expected |
	expected := Object new.
	pool creator: [expected].
	self should: [pool borrow = expected].
]

{ #category : #tests }
OPBasicPoolTest >> testObjectsAreDestroyed [
	| a creatorCount destroyed |
	creatorCount := 0.
	destroyed := false.
	pool creator: [Object new.].
	pool destroyer: [:o | self should: [o = a]. destroyed := true].
	a := pool borrow.
	pool return: a.
	pool clear.
	self shouldnt: [pool isPooled: a].
	self should: destroyed.	
	
]

{ #category : #tests }
OPBasicPoolTest >> testObjectsArePooled [
	| a creatorCount |
	creatorCount := 0.
	pool creator: [Object new. creatorCount := creatorCount  + 1].
	a := pool borrow.
	pool return: a.
	a := pool borrow.
	pool return: a.
	self should:[creatorCount = 1].
	
]

{ #category : #tests }
OPBasicPoolTest >> testObjectsAreValidatedBeforBorrow [
	| expected called |
	called := false.
	expected := Object new.
	pool creator: [expected].
	pool validator: [:o|self should:[expected = o]. called := true.].
	expected := pool borrow.
	self should: called.
]

{ #category : #tests }
OPBasicPoolTest >> testPassivatedObjectsAreActivatedWhenBorrowed [
	| object|
	pool creator: [ValueHolder new contents: ''.].
	pool passivator:[:o| o contents: o contents,'p'].
	pool activator:[:o| o contents: o contents,'a'].
	pool return: pool borrow.
	pool return: pool borrow.
	object := pool borrow.
	self should: [object contents = 'papa'].

]
