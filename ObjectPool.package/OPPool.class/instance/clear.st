pooling
clear
	"Removes all objects from the pool and reinitializes it.
	Method will run the destroyer for every pooled objects."

	| oldObjects |
	lock
		critical: [ 
			oldObjects :=  IdentitySet withAll: idleObjects.
			idleObjects removeAll ].
	oldObjects do: [ :o | self destroyObject: o ]