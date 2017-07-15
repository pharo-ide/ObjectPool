pool configuration
minIdleObjects: anInteger
"
Sets the minum ammount of idle objects that are tried to keep on this pool.
Method also creates more idle objects if there are not enough them at the moment.
"
	minIdleObjects := anInteger.
	self ensureMinimumIdleObjects.