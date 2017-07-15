as yet unclassified
hasEnoughIdleObjects
	^ minIdleObjects ifNil: [ true ] ifNotNil: [ idleObjects size >= minIdleObjects ]