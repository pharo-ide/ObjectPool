as yet unclassified
whileNotEnoughIdleObjects: aBlock
	^ [self hasEnoughIdleObjects] whileFalse: aBlock.