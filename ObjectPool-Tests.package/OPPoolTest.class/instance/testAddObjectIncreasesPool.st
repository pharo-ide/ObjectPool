tests
testAddObjectIncreasesPool
	self should: 0 = pool numberOfIdleObjects.
	self should: 0 = pool numberOfActiveObjects.
	pool addObject.
	self should: 1 = pool numberOfIdleObjects.
	self should: 0 = pool numberOfActiveObjects.
	pool addObject.
	self should: 2 = pool numberOfIdleObjects.
	self should: 0 = pool numberOfActiveObjects.