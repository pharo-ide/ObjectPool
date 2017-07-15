private
objectForBorrow
	^self objectFromPoolOrElse: [ self makeObject ]