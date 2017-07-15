tests
testFixMaxActiveObjects

	pool creator: [ Object new ].
	pool maxActiveObjects: nil.
	self
		borrowOne;
		borrowOne.
	pool objectToPool: Object new.
	pool fixMaxActiveObjects.
	
	self assert: pool maxActiveObjects = 3