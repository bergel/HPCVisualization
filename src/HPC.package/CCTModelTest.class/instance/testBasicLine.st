as yet unclassified
testBasicLine

	| node |
	node := CCTNode new.
	node fromLine: self exampleLine1.
	
	self assert: node id equals: 0.
	self assert: node nodeName equals: 'zeusmp'.
	self assert: node metrics first equals: 0.04255