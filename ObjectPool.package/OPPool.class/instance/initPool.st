initialization
initPool
	idleObjects := IdentitySet new.
	borrowedObjects := IdentitySet new.
	lock := Monitor new.
