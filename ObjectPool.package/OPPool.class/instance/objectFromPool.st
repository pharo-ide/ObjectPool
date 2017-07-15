private
objectFromPool
	"Return an activated object from pool. Should not be called if there are no
	free objects in the pool."

	| object |
	self critical: [ object := idleObjects remove: idleObjects anyOne ].
	self activateObject: object.
	^ object