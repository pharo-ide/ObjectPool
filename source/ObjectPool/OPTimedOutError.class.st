"
ObjectPoolTimedOutError is thrown when pool does not obtain object to be borrowed as fast as required. This
may signal that pool is full for too long or there is some problem in the object creation.
"
Class {
	#name : 'OPTimedOutError',
	#superclass : 'OPError',
	#category : 'ObjectPool',
	#package : 'ObjectPool'
}
