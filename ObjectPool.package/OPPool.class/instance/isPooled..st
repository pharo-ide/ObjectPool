testing
isPooled: anObject
	"Returns true if given object is pooled in this pool. Returns false otherwise.
	Method does not depend on whether object is currently borrowed or not.
	"

	lock critical: [ ^ (borrowedObjects includes: anObject) or: [idleObjects includes: anObject] ].