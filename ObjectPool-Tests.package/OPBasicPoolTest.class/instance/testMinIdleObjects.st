tests
testMinIdleObjects

	pool creator: [Object new].
	pool minIdleObjects: 5.
	self should: 5 = pool numberOfIdleObjects.
	pool creator: [self fail]. "We should have 5 idle objects so creator should not be called."
	5 timesRepeat: [pool borrow].
