object-lifecycle
validateObject: anObject
	^ validator ifNil: [ true ] ifNotNil: [ validator value: anObject ]