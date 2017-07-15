tests
testClearEmptiesIdleObjects
	self borrowOne;returnOne.
	self should: 1 = pool numberOfIdleObjects.
	pool clear.
	self should: 0 = pool numberOfIdleObjects.