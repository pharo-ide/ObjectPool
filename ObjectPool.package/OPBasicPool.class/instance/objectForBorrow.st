as yet unclassified
objectForBorrow
	self critical: [ 
	maxActiveObjects
		ifNotNil: [ 
			maxWaitForBorrow
				ifNil: [ self waitUntil: [ self numberOfActiveObjects < maxActiveObjects ] ]
				ifNotNil: [ self waitUntil: [ self numberOfActiveObjects < maxActiveObjects ] timoutAfterMilliseconds: maxWaitForBorrow ] ].
	].
	
	^ super objectForBorrow