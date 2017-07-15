object-lifecycle
destroyObject: anObject
	destroyer isNil ifFalse:[destroyer value: anObject].