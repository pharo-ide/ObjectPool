testing
numberOfAvailableObjects
	^self critical: [borrowedObjects size + idleObjects size].