tests
testIsPooled
	| object |
	pool
		withPooled: [ :o | 
			object := o.
			self should: (pool isPooled: object) ].
	self should: (pool isPooled: object).
	pool clear.
	self shouldnt: (pool isPooled: object)