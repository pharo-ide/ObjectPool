private
objectFromPoolOrElse: notAvailableBlock
	"Returns activated object from queue or runs given block."

	^idleObjects 
		ifEmpty: notAvailableBlock 
		ifNotEmpty: [ self objectFromPool ]