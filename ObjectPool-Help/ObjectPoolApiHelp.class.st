Class {
	#name : #ObjectPoolApiHelp,
	#superclass : #ObjectPoolHelp,
	#category : 'ObjectPool-Help'
}

{ #category : #'accessing' }
ObjectPoolApiHelp class >> bookName [
	<ignoreForCoverage>
  ^'Reference'
]

{ #category : #'accessing' }
ObjectPoolApiHelp class >> builder [
  <ignoreForCoverage>
  ^PackageAPIHelpBuilder
]

{ #category : #'accessing' }
ObjectPoolApiHelp class >> helpPackages [
	<ignoreForCoverage>
  ^#('ObjectPool' 'ObjectPool-Tests')
]
