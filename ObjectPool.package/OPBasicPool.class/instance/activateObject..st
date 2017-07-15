object-lifecycle
activateObject: anObject
	activator isNil ifFalse:[activator value: anObject].
	^anObject.