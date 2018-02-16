pooling
fixMaxActiveObjects

	self critical: [maxActiveObjects := self numberOfAvailableObjects].