Extension { #name : 'OPPool' }

{ #category : '*ObjectPool-Pharo' }
OPPool >> waitUntil: aBlock timeoutAfterMilliseconds: aNumber [
"Waits signal on synchronization lock until aBlock evaluates true or more than
given milliseconds have passed then OPTimedOutError is signaled."
	| startTime |
	startTime := self currentMilliseconds.
	lock
		waitUntil: [ 
			self currentMilliseconds - startTime > aNumber
				ifTrue: [ OPTimedOutError signal ].
			aBlock value.]
		maxMilliseconds: aNumber
]
