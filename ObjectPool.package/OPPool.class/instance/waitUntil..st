synchronizing
waitUntil: aBlock
"Waits signal on synchronization lock until given block evaluates true."
	lock waitUntil: aBlock.  