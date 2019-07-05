Class {
	#name : #OPPoolTest,
	#superclass : #OPPoolTestCase,
	#category : 'ObjectPool-Tests'
}

{ #category : #running }
OPPoolTest >> poolClass [
	 ^OPPoolStub.
]

{ #category : #tests }
OPPoolTest >> testAddObjectIncreasesPool [
	self should: 0 = pool numberOfIdleObjects.
	self should: 0 = pool numberOfActiveObjects.
	pool addObject.
	self should: 1 = pool numberOfIdleObjects.
	self should: 0 = pool numberOfActiveObjects.
	pool addObject.
	self should: 2 = pool numberOfIdleObjects.
	self should: 0 = pool numberOfActiveObjects.
]

{ #category : #tests }
OPPoolTest >> testBorrowReturnsNonNil [
	| borrowedObject |
	borrowedObject := self borrowOne.
	^self shouldnt: borrowedObject isNil. 
]

{ #category : #tests }
OPPoolTest >> testBorrowReusesReturned [
	| borrowedObject secondBorrowedObject |
	borrowedObject := self borrowOne.
	self returnOne.
	secondBorrowedObject := self borrowOne. 
	^self should: borrowedObject = secondBorrowedObject.
]

{ #category : #tests }
OPPoolTest >> testClearDoesNotTouchActiveObjects [
	self borrowOne;borrowOne.
	self should: 2 = pool numberOfActiveObjects.
	pool clear.
	self should: 2 = pool numberOfActiveObjects.
	self returnOne; returnOne.
]

{ #category : #tests }
OPPoolTest >> testClearEmptiesIdleObjects [
	self borrowOne;returnOne.
	self should: 1 = pool numberOfIdleObjects.
	pool clear.
	self should: 0 = pool numberOfIdleObjects.
]

{ #category : #tests }
OPPoolTest >> testIsPooled [
	| object |
	pool
		withPooled: [ :o | 
			object := o.
			self should: (pool isPooled: object) ].
	self should: (pool isPooled: object).
	pool clear.
	self shouldnt: (pool isPooled: object)
]

{ #category : #tests }
OPPoolTest >> testNumberOfActiveObjects [
	self should: 0 = pool numberOfActiveObjects.
	self borrowOne.
	self should: 1 = pool numberOfActiveObjects.
	self borrowOne.
	self should: 2 = pool numberOfActiveObjects.
	self returnOne.
	self should: 1 = pool numberOfActiveObjects.
	self returnOne.
	self should: 0 = pool numberOfActiveObjects.

]

{ #category : #tests }
OPPoolTest >> testNumberOfIdleObjects [
	self should: 0 = pool numberOfIdleObjects.
	self borrowOne.
	self should: 0 = pool numberOfIdleObjects.
	self returnOne.
	self should: 1 = pool numberOfIdleObjects.
	self borrowOne; returnOne.
	self should: 1 = pool numberOfIdleObjects.
	self borrowOne; borrowOne; returnOne; returnOne.
	self should: 2 = pool numberOfIdleObjects.

]

{ #category : #tests }
OPPoolTest >> testReturnDoesNotAcceptObjectNonBorrowedObject [
	| expected |
	expected := Object new.
	self should: [ pool return: expected ] raise: OPWrongPoolError
]

{ #category : #tests }
OPPoolTest >> testReturnDoesNotAcceptSameObjectTwice [
	| expected |
	expected := pool borrow.
	pool return: expected.
	self should: [pool return: expected] raise: OPWrongPoolError.

]

{ #category : #tests }
OPPoolTest >> testWithPooled [
	pool withPooled: [ :o | self should: 1 = pool numberOfActiveObjects ].
	self should: 0 = pool numberOfActiveObjects.
	self should: 1 = pool numberOfIdleObjects
]
