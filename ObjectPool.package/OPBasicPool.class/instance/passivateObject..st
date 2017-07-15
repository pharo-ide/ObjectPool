object-lifecycle
passivateObject: anObject
	passivator isNil ifFalse: [ passivator value: anObject ].