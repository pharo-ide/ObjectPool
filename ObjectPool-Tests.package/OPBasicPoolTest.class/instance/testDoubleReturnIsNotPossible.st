tests
testDoubleReturnIsNotPossible
	| expected called |
	called := false.
	pool creator: [ Object new ].
	expected := pool borrow.
	pool passivator: [:o|called :=true. self should: [o=expected].].
	pool return: expected.
	self should: [pool return: expected] raise: Exception.
	self should: called.