tests
testNonValidObjectsAreDestroyed
	| called count objects|
	objects := OrderedCollection new.
	called := false.
	count := 0.
	pool creator: [objects add: Object new].
	pool return: pool borrow.
	pool validator: [:o|count := count + 1. count > 1. ].
	pool destroyer: [:o|called := true].
	pool borrow.
	self should: called.
	self shouldnt: [pool isPooled: objects first].
	self should: [pool isPooled: objects second].