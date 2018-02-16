pooling
borrow
	"Returns activated object from pool or creates new pooled object and returns it."

	| object |
	[ object := self unsafeBorrow.
	self objectGoingToBeBorrowed: object]
		on: OPAbortOperation
		do: [ :e | 
			self critical: [borrowedObjects remove: object].
			self destroyObject: object.
			e retry ].
	^ object