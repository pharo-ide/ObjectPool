tests
testClearDoesNotTouchActiveObjects
	self borrowOne;borrowOne.
	self should: 2 = pool numberOfActiveObjects.
	pool clear.
	self should: 2 = pool numberOfActiveObjects.
	self returnOne; returnOne.