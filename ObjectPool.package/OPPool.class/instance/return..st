pooling
return: anObject
	"Returns previously borrowed object from the pool. If object is not from this pool then
	ObjectPoolWrongPoolError is raised."

	self critical: [ 
		(borrowedObjects includes: anObject)
			ifFalse: [ OPWrongPoolError signal: 'Object is not from this pool instance.' ]].
	
	[self objectGoingToBeReturned: anObject] on: OPAbortOperation do: [ 
		^self destroyObject: anObject].
	
	self critical: [
		borrowedObjects remove: anObject.
		self objectToPool: anObject]