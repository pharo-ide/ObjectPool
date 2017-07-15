tests
testReturnDoesNotAcceptObjectNonBorrowedObject
	| expected |
	expected := Object new.
	self should: [ pool return: expected ] raise: OPWrongPoolError