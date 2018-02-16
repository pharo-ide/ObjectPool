pooling
hasEnoughIdleObjects
	^ minIdleObjects ifNil: [ true ] ifNotNil: [ idleObjects size >= minIdleObjects ]