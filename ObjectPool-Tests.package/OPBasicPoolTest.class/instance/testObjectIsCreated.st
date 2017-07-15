tests
testObjectIsCreated
	| expected |
	expected := Object new.
	pool creator: [expected].
	self should: [pool borrow = expected].