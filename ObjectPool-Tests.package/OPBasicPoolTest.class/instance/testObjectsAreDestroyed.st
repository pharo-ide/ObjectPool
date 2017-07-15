tests
testObjectsAreDestroyed
	| a creatorCount destroyed |
	creatorCount := 0.
	destroyed := false.
	pool creator: [Object new.].
	pool destroyer: [:o | self should: [o = a]. destroyed := true].
	a := pool borrow.
	pool return: a.
	pool clear.
	self shouldnt: [pool isPooled: a].
	self should: destroyed.	
	