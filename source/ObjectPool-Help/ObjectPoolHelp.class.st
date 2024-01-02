"
This is HelpSystem documentation for ObjectPool.
"
Class {
	#name : #ObjectPoolHelp,
	#superclass : #CustomHelp,
	#category : 'ObjectPool-Help'
}

{ #category : #'accessing' }
ObjectPoolHelp class >> bookName [
  <ignoreForCoverage>
	^'ObjectPool'
]

{ #category : #'accessing' }
ObjectPoolHelp class >> introduction [
  <ignoreForCoverage>
	^HelpTopic title: 'Introduction' contents:
'Object Pool offers easy way to build pools for objects. One common situation
could be pooling database connections. This library was created for supporting pooling
of GlorpDBX database connections. However GlorpDBX related code is different
package.

Objects borrowed from OPPool have following basic lifecycle:

1. Objects are first created.
2. When objects are borrowed from pool they are activated..
3. When objects are returned to pool they are passivated.
4. When objects is no longer usable (some lifecycle operation fails) or needed it is destroyed.

See documentation of #OPPool for more information about lifecycle. There is also
OPBasicPool that does validation to check if objects are still usable.

This library was developed for University of Jyväskylä under MIT-license.

panu.suominen@iki.fi
'.
]

{ #category : #'accessing' }
ObjectPoolHelp class >> pages [
  <ignoreForCoverage>
	^#(introduction usage )
]

{ #category : #'accessing' }
ObjectPoolHelp class >> usage [
  <ignoreForCoverage>
	^HelpTopic title: 'Basic usage' contents:
'To create pool for of OrderedCollections one could write:
	OPBasicPool new
		creator: [OrderedCollection new].
	
To get new collection from the pool:
	pool withPooled: [:o| "Do something"].
	
To also clear collections when they are returned add passivator
	pool passivator:[:o|o removeAll].
	
Or to do that before borrow add activator:
	pool activator:[:o|o removeAll].
	
To validate objects before borrow add following. Objects that do not validate are destroyed.
	pool validator:[:o|o size = 0].
	
One can set maximum size of pool with #maxIdleObjects. See more about pool configuration
in documentation of OPBasicPool.
'.
]
