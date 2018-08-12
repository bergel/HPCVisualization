as yet unclassified
testBasicLine2

	| node |
	node := CCTNode new.
	node fromLine: self exampleLine2.
	
	self assert: node id equals: 1.
	self assert: node nodeName equals: 'configure'.
	self assert: node metrics third equals: 3.50365e-05