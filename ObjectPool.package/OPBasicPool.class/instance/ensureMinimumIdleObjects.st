pooling
ensureMinimumIdleObjects
	self critical: [ self whileNotEnoughIdleObjects: [ self addObject ] ]