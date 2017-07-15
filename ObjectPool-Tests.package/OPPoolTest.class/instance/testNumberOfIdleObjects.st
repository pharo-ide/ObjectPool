tests
testNumberOfIdleObjects
	self should: 0 = pool numberOfIdleObjects.
	self borrowOne.
	self should: 0 = pool numberOfIdleObjects.
	self returnOne.
	self should: 1 = pool numberOfIdleObjects.
	self borrowOne; returnOne.
	self should: 1 = pool numberOfIdleObjects.
	self borrowOne; borrowOne; returnOne; returnOne.
	self should: 2 = pool numberOfIdleObjects.
