tests
testReturnDoesNotAcceptSameObjectTwice
	| expected |
	expected := pool borrow.
	pool return: expected.
	self should: [pool return: expected] raise: OPWrongPoolError.
