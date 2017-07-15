tests
testNumberOfAvailableObjects

	pool creator: [ Object new ].
	pool maxActiveObjects: nil.
	self
		borrowOne;
		borrowOne.
	pool objectToPool: Object new.
		
	self assert: pool numberOfAvailableObjects = 3