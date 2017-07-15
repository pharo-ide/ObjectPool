I am base class for object pool tests. I implement #borrowOne and #returnOne conviency methods to help test writing.

Instance Variables:
	pool	<OPPool>					The pool that is tested
	borrowed	<OrderedCollection>	Collection that contains currently borrowed objects. #borrowOne adds one from pool and #returnOne 										removes one and returns it back to pool.