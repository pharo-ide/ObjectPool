events
isFull
	^ maxIdleObjects ifNil: [ false ] ifNotNil: [ idleObjects size >= maxIdleObjects ]