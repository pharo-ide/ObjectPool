tests
testBorrowReusesReturned
	| borrowedObject secondBorrowedObject |
	borrowedObject := self borrowOne.
	self returnOne.
	secondBorrowedObject := self borrowOne. 
	^self should: borrowedObject = secondBorrowedObject.