instance creation
fromLine: aString
	| elements firstElemet |
	elements := aString substrings: ' '.
	firstElemet := elements first substrings: '()='.
	nodeName := firstElemet first.
	id := firstElemet last asInteger.
	metrics := elements allButFirst collect: [ :numberAsString | Float readFrom: numberAsString ].
	