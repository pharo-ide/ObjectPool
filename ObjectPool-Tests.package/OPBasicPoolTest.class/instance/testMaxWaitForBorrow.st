tests
testMaxWaitForBorrow
	"Test that borrow operation throws OPTimedOutError"

	pool creator: [ Object new ].
	pool maxActiveObjects: 1.
	pool maxWaitForBorrow: 50.
	self
		should: [ 
			self borrowOne.
			self should: [ self borrowOne ] raise: OPTimedOutError ]
		notTakeMoreThan: 0.2 seconds asDuration