tests
testWithPooled
	pool withPooled: [ :o | self should: 1 = pool numberOfActiveObjects ].
	self should: 0 = pool numberOfActiveObjects.
	self should: 1 = pool numberOfIdleObjects