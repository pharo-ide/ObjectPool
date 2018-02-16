private
unsafeBorrow
	| object |
	object := self objectFromPoolOrElse: [ self makeObject ].
	self critical: [borrowedObjects add: object].
	^object