tests
testObjectCanBeReturned
	| expected called |

	called := false.
	pool creator: [Object new].
	expected := pool borrow.
	pool passivator: [:o|called :=true. self should: [o=expected].].
	pool return: expected.
	self should: called.