pooling
withPooled: oneArgumentBlock
	"Runs given block with object from the pool."
	| o |
	o := self borrow.
	^[oneArgumentBlock cull: o ] ensure: [ self return: o ]