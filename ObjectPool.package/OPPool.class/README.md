I am general and abstract pool for objects. Objects are borrowed from pool using #borrow and returned to pool using #return:. There
is convience method #withPooled: to run one argument block with pooled object. To create minimal usable pool one can make subclass and
override #makeObject method. See OPBasicPool for more usable implementation. 

Pooled objects have general lifecycle. Subclasses can perform needed operations on these lifecycle steps.
Life cycle and corresponding methods are following:

1. Object is created. (#makeObject)
		This occurs for example when there is not enough objects to be borrowd and there is room in the pool.
		
2. Object is activated. (#activateObject:)
		This happens to all objects that have been previously passivated when they are borrowed.
				
4. Object is passivated. (#passivateObject:)
		This happens when object is returned to the pool.
		
5. Object is destroyed. (#destroyObject:)
		This happens when object is no longer usable (any lifecycle operation fails) or pool is shrinked.

In addition to this lifecycle there are "event" handling methods: #objectGoingToBeBorrowed:, #objectGoingToBeReturned:.
These methods can be used to veto object borrowing or returning by throwing OPAbortOperation. Aborting return 
prevents object getting back to idleObjects set. Preventing borrow causes pool to try borrowing again. In both
cases the object is destroyed using #destroyObject:.
		
Instance Variables:
	lock            		<Monitor>		Monitor used to synchronize object.
	idleObjects 		<IdentitySet>			Objects that currenlty idle. Idle objects are in passive state.
	borrowedObjects	<IdentitySet>			Objects that have been lended outside of the pool.
