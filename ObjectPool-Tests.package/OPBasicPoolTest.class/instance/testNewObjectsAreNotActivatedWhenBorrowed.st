tests
testNewObjectsAreNotActivatedWhenBorrowed
	| expected |
	
	pool creator: [ValueHolder new contents:'p'].
	pool activator:[:o | o contents:'a'].
	expected := pool borrow.
	self should: [expected contents = 'p'].
