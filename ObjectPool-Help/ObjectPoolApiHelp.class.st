Class {
	#name : #ObjectPoolApiHelp,
	#superclass : #ObjectPoolHelp,
	#category : 'ObjectPool-Help'
}

{ #category : #'as yet unclassified' }
ObjectPoolApiHelp class >> bookName [
	^'Reference'
]

{ #category : #'as yet unclassified' }
ObjectPoolApiHelp class >> builder [
	^PackageAPIHelpBuilder
]

{ #category : #'as yet unclassified' }
ObjectPoolApiHelp class >> helpPackages [
	^#('ObjectPool-Core')
]

{ #category : #'as yet unclassified' }
ObjectPoolApiHelp class >> packages [
	^#('ObjectPool-Core')
]
