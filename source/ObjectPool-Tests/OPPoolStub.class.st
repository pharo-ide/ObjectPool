"
I exists just for testing OPPool. I implement the mandatory #makeObject method.
"
Class {
	#name : #OPPoolStub,
	#superclass : #OPPool,
	#category : 'ObjectPool-Tests'
}

{ #category : #'object-lifecycle' }
OPPoolStub >> makeObject [
	 ^ Object new.
]
