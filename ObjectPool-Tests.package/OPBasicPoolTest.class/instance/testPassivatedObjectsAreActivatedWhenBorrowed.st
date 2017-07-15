tests
testPassivatedObjectsAreActivatedWhenBorrowed
	| object|
	pool creator: [ValueHolder new contents: ''.].
	pool passivator:[:o| o contents: o contents,'p'].
	pool activator:[:o| o contents: o contents,'a'].
	pool return: pool borrow.
	pool return: pool borrow.
	object := pool borrow.
	self should: [object contents = 'papa'].
