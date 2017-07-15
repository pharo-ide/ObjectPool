as yet unclassified
usage
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
	
To validate objets before borrow add following. Objects that do not validate are destroyed.
	pool validator:[:o|o size = 0].
	
One can set maximum size of pool with #maxIdleIbjects. See more about pool configuration
in documentation of OPBasicPool.
'.