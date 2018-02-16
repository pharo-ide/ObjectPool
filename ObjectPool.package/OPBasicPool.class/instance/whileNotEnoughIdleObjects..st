pooling
whileNotEnoughIdleObjects: aBlock
	^ [self hasEnoughIdleObjects] whileFalse: aBlock.