tests
testErrorInPassivatorIsNotEated

	pool creator: [Object new].
	pool passivator:[:o|Error signal].
	self should: [pool return: pool borrow] raise: Error.
