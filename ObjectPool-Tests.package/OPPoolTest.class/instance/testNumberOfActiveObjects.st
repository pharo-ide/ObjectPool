tests
testNumberOfActiveObjects
	self should: 0 = pool numberOfActiveObjects.
	self borrowOne.
	self should: 1 = pool numberOfActiveObjects.
	self borrowOne.
	self should: 2 = pool numberOfActiveObjects.
	self returnOne.
	self should: 1 = pool numberOfActiveObjects.
	self returnOne.
	self should: 0 = pool numberOfActiveObjects.
