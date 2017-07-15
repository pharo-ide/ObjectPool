tests
testMigrationObjectsToAnotherPoolWhichHasMaxObjectsLimit

	| anotherPool |
	pool objectToPool: #object1.
	pool objectToPool: #object2.
	
	anotherPool := self poolClass new.
	anotherPool maxActiveObjects: 1.
	
	pool migrateObjectsInto: anotherPool andDo: [:each | ].
	
	self assert: {anotherPool borrow. anotherPool borrow} asSet equals: #(#object1 #object2) asSet.
	
	self assert: anotherPool numberOfAvailableObjects = 2.
	self assert: anotherPool maxActiveObjects = 2