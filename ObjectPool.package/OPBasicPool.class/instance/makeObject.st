object-lifecycle
makeObject
	creator ifNil: [ self error: 'Creator should not be nil' ].
	^creator value.