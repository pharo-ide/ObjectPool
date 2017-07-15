tests
testMaxActiveObjectsOneDoesNotBlockFirstBorrow
	"Test that 1 maxActieObjects can return one object"
	pool creator: [ Object new ].
	pool maxActiveObjects: 1.
	self should: [self borrowOne] notTakeMoreThan: 0.1 seconds asDuration.