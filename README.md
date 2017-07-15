# ObjectPool
Object Pool offers easy way to build pools for objects. One common situation
could be pooling database connections. This library was created for supporting pooling
of GlorpDBX database connections. However GlorpDBX related code is different
package.

Objects borrowed from OPPool have following basic lifecycle:

1. Objects are first created.
2. When objects are borrowed from pool they are activated..
3. When objects are returned to pool they are passivated.
4. When objects is no longer usable (some lifecycle operation fails) or needed it is destroyed.

To create pool for of OrderedCollections one could write:
```Smalltalk
OPBasicPool new
	creator: [OrderedCollection new].
```
To get new collection from the pool:
```Smalltalk
pool withPooled: [:o| "Do something"].
```	
To also clear collections when they are returned add passivator
```Smalltalk
pool passivator:[:o|o removeAll].
```	
Or to do that before borrow add activator:
```Smalltalk
pool activator:[:o|o removeAll].
```
To validate objects before borrow add following. Objects that do not validate are destroyed.
```Smalltalk
pool validator:[:o|o size = 0].
```
One can set maximum size of pool with #maxIdleIbjects. See more about pool configuration
in documentation of OPBasicPool.

## Installation
```Smalltalk
Metacello new
  baseline: 'ObjectPool';
  repository: 'github://dionisiydk/ObjectPool';
  load
```
