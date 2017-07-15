tests
testMaxIdleObjects
	pool creator: [Object new].
	pool maxIdleObjects: 2.
	self borrowOne;borrowOne;returnOne;returnOne.
	self should: 2 = pool numberOfIdleObjects.
	self borrowOne;borrowOne;borrowOne;returnOne;returnOne;returnOne.
	self should: 2 = pool numberOfIdleObjects.
