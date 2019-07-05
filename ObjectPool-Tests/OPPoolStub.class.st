"
I exists just for testing OPPool. I implement the mandatory #makeObject mehtod.
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
