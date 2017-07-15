as yet unclassified
migrateObjectsInto: anotherPool andDo: aBlock

	self critical: [ 
		borrowedObjects ifNotEmpty: [ self error: 'Pool allow migration only when al objects are free' ].
		
		idleObjects do: [ :each | 
			anotherPool objectToPool: each.
			aBlock value: each].
		anotherPool fixMaxActiveObjects.
		idleObjects removeAll]