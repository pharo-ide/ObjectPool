tests
testAlteringObjectIsOK
	| object |
	pool creator: [Array new: 1].
	object := pool borrow.
	object at: 1 put: 66.
	pool return: object.
	
	