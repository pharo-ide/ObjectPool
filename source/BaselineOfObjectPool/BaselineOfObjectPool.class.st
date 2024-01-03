Class {
	#name : 'BaselineOfObjectPool',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfObjectPool',
	#package : 'BaselineOfObjectPool'
}

{ #category : 'baselines' }
BaselineOfObjectPool >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec package: 'ObjectPool'.
		spec package: 'ObjectPool-Pharo' with: [ spec requires: 'ObjectPool' ].
		spec package: 'ObjectPool-Tests' with: [ spec requires: 'ObjectPool-Pharo' ].
		spec package: 'ObjectPool-Help' with: [ spec requires: 'ObjectPool-Pharo' ].
		spec group: 'default' with: #( 'Core' 'Tests' 'ObjectPool-Help' ).
		spec group: 'Core' with: #( 'ObjectPool' 'ObjectPool-Pharo' ).
		spec group: 'Tests' with: #( 'ObjectPool-Tests' )
		]
]
