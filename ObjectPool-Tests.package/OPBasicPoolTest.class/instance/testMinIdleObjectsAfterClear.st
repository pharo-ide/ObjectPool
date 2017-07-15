tests
testMinIdleObjectsAfterClear

	pool creator: [Object new].
	pool minIdleObjects: 5.
	pool clear.
	self should: 5 = pool numberOfIdleObjects.