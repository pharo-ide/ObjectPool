tests
testMaxWaitForBorrowDoesNotAffectIfActiveCountIsNotReached
	pool creator: [ Object new ].
	pool maxWaitForBorrow: 75.
	self should:[self
		borrowOne;
		borrowOne] notTakeMoreThan: 0.1 seconds asDuration.