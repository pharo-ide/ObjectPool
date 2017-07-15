tests
testIsPooledWorks
	| expected|

	expected := Object new.
	pool creator: [Object new].
	self should: [pool isPooled: pool borrow].
