tests
testObjectsAreValidatedBeforBorrow
	| expected called |
	called := false.
	expected := Object new.
	pool creator: [expected].
	pool validator: [:o|self should:[expected = o]. called := true.].
	expected := pool borrow.
	self should: called.