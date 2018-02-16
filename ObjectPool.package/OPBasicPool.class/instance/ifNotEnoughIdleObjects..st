pooling
ifNotEnoughIdleObjects: aBlock
	^ self hasEnoughIdleObjects ifTrue: aBlock