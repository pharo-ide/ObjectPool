tests
testMaxActiveObjects
	"Test that new objects can be returned only after there is room in active objects"

	| runTime semaphore |
	semaphore := Semaphore new.
	pool creator: [ Object new ].
	pool maxActiveObjects: 2.
	self
		borrowOne;
		borrowOne.
	[ 
	semaphore signal.
	0.1 seconds asDelay wait.
	self returnOne ] fork.
	semaphore wait.
	runTime := [ self borrowOne ] timeToRun.
	self should: runTime > 75 milliSeconds