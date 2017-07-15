tests
testObjectsArePooled
	| a creatorCount |
	creatorCount := 0.
	pool creator: [Object new. creatorCount := creatorCount  + 1].
	a := pool borrow.
	pool return: a.
	a := pool borrow.
	pool return: a.
	self should:[creatorCount = 1].
	