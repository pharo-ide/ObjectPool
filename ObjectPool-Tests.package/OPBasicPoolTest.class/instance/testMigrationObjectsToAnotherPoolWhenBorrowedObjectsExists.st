tests
testMigrationObjectsToAnotherPoolWhenBorrowedObjectsExists

	| anotherPool |
	pool objectToPool: #object1.
	pool objectToPool: #object2.
	pool borrow.
	
	anotherPool := self poolClass new.
	
	[pool migrateObjectsInto: anotherPool andDo: nil.
	self assert: false description: 'should raise error'
	] ifError: [].
		
	self assert: anotherPool numberOfAvailableObjects = 0.
	self assert: pool numberOfAvailableObjects = 2