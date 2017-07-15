pooling
borrow
	"Returns activated object from pool or creates new pooled object and returns it."

	| object |
	[ 
	object := self objectForBorrow.
	self objectGoingToBeBorrowed: object.
	self critical: [borrowedObjects add: object] ]
		on: OPAbortOperation
		do: [ :e | 
			self destroyObject: object.
			e retry ].
	^ object