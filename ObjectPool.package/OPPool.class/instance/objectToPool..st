private
objectToPool: anObject
	"Puts object back to pool"
	self passivateObject: anObject.
	self
		critical: [ 
			idleObjects add: anObject.
			self signalIdleAvailable ]