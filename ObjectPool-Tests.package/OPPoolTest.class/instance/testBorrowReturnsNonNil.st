tests
testBorrowReturnsNonNil
	| borrowedObject |
	borrowedObject := self borrowOne.
	^self shouldnt: borrowedObject isNil. 