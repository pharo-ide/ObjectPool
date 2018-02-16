pooling
unsafeBorrow
	| newObject |
	self critical: [ 
		maxActiveObjects ifNotNil: [ 
			maxWaitForBorrow
				ifNil: [ self waitUntil: [ self numberOfActiveObjects < maxActiveObjects ] ]
				ifNotNil: [ self waitUntil: [ self numberOfActiveObjects < maxActiveObjects ] timoutAfterMilliseconds: maxWaitForBorrow ]].
		idleObjects ifNotEmpty: [ 
			^ borrowedObjects add: self objectFromPool ]	].
	newObject := self makeObject.
	self critical: [borrowedObjects add: newObject].
	^newObject