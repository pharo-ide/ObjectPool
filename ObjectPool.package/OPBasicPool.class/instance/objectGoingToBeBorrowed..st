events
objectGoingToBeBorrowed: anObject
	(self validateObject: anObject) ifFalse: [OPAbortOperation signal]