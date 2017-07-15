tests
testMigrationObjectsToAnotherPool

	| anotherPool migrated |
	pool objectToPool: #object1.
	pool objectToPool: #object2.
	
	migrated := OrderedCollection new.
	anotherPool := self poolClass new.
	
	pool migrateObjectsInto: anotherPool andDo: [:each | migrated add: each ].
	
	self assert: {anotherPool borrow. anotherPool borrow} asSet equals: #(#object1 #object2) asSet.
	
	self assert: anotherPool numberOfAvailableObjects = 2.
	self assert: pool numberOfAvailableObjects = 0.
	self assert: migrated asSet equals: #(#object1 object2) asSet