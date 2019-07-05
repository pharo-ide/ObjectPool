Class {
	#name : #BaselineOfObjectPool,
	#superclass : #BaselineOf,
	#category : 'BaselineOfObjectPool'
}

{ #category : #baselines }
BaselineOfObjectPool >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec package: #'ObjectPool'.
			spec package: #'ObjectPool-Tests' with: [ spec requires: #(#'ObjectPool') ].
			spec package: #'ObjectPool-Help' with: [ spec requires: #(#'ObjectPool') ].
			spec group: 'default' with: #('Core' 'Tests' #'ObjectPool-Help').
			spec group: 'Core' with: #(#'ObjectPool').
			spec group: 'Tests' with: #(#'ObjectPool-Tests' #'ObjectPool-Help')]
]
