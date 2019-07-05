"
I am base class for object pool tests. I implement #borrowOne and #returnOne conviency methods to help test writing.

Instance Variables:
	pool	<OPPool>					The pool that is tested
	borrowed	<OrderedCollection>	Collection that contains currently borrowed objects. #borrowOne adds one from pool and #returnOne 										removes one and returns it back to pool.
"
Class {
	#name : #OPPoolTestCase,
	#superclass : #TestCase,
	#instVars : [
		'pool',
		'borrowed'
	],
	#category : 'ObjectPool-Tests'
}

{ #category : #testing }
OPPoolTestCase class >> isAbstract [
	^self == OPPoolTestCase 
]

{ #category : #running }
OPPoolTestCase >> borrowOne [
	^borrowed add: pool borrow.
]

{ #category : #running }
OPPoolTestCase >> poolClass [
	self subclassResponsibility.
]

{ #category : #running }
OPPoolTestCase >> returnOne [
	^pool return: borrowed removeLast.
]

{ #category : #running }
OPPoolTestCase >> setUp [
	pool := self poolClass new.
	borrowed := OrderedCollection new.
]
