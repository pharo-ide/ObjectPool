as yet unclassified
ensureMinimumIdleObjects
	self critical: [ self whileNotEnoughIdleObjects: [ self addObject ] ]