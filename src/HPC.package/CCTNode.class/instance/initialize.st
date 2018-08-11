initialization
initialize
	super initialize.
	id := -1.
	nodeName := 'NONAME'.
	metrics := OrderedCollection new.
	
	parent := -1.
	children := OrderedCollection new.
	