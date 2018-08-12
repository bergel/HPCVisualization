Class {
	#name : #CCTFunction,
	#superclass : #Object,
	#instVars : [
		'functionName',
		'cctNodes',
		'incomingFunctions',
		'outgoingFunctions'
	],
	#category : 'HPC'
}

{ #category : #adding }
CCTFunction >> addIncomingFunction: f [
	incomingFunctions add: f
]

{ #category : #adding }
CCTFunction >> addNode: aCCTNode [
	cctNodes add: aCCTNode 
]

{ #category : #adding }
CCTFunction >> addOutgoingFunction: f [
	outgoingFunctions add: f
]

{ #category : #'public - computing share' }
CCTFunction >> allShares [
	"Return the list of ratio of execution time for the incoming functions call"
	^ incomingFunctions collect: [ :f | self shareOfFunction: f ]
]

{ #category : #adding }
CCTFunction >> functionName [
	"Return the name of the function"
	^ functionName
]

{ #category : #adding }
CCTFunction >> functionName: aFunctionName [
	"Set the name of the function"
	functionName := aFunctionName 
]

{ #category : #visualizations }
CCTFunction >> gtInspectorGroupIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'Function';
		initializeView: [ 
			self visualizeFunction  ]
]

{ #category : #accessing }
CCTFunction >> incomingFunctions [
	"Return the list of functions that invoke me"
	^ incomingFunctions 
]

{ #category : #initialization }
CCTFunction >> initialize [
	super initialize.
	cctNodes := OrderedCollection new.
	incomingFunctions := OrderedCollection new.
	outgoingFunctions := OrderedCollection new
]

{ #category : #accessing }
CCTFunction >> metricValue [
	"This method return a value describing the performance. The definition should probably be improved in the future"
	^ self metricValueOfNodes: cctNodes
]

{ #category : #accessing }
CCTFunction >> metricValueOfNodes: someCCTNodes [
	"This method return a value describing the performance. The definition should probably be improved in the future"
	^ (someCCTNodes collect: [ :n | n metrics average ]) sum.
]

{ #category : #accessing }
CCTFunction >> nodes [
	"Return the nodes that correspond to the function"
	^ cctNodes 
]

{ #category : #accessing }
CCTFunction >> numberOfNodes [
	"Return the number of nodes my functions represents"
	^ self nodes size
]

{ #category : #accessing }
CCTFunction >> outgoingFunctions [
	"Return the list of functions that receive a call from me"
	^ outgoingFunctions 
]

{ #category : #printing }
CCTFunction >> printOn: str [
	str nextPut: $<.
	str nextPutAll: functionName.
	str nextPut: $>.
]

{ #category : #'public - computing share' }
CCTFunction >> shareOfFunction: aFunction [
	"Return the ratio of my execution time with the incoming function provided as argument"
	
	"We get the nodes that have the method argument as parent function"
	| nodesToBeComputed toBeComputed |
	nodesToBeComputed := cctNodes select: [ :aNode | aNode parent function == aFunction ].
	toBeComputed := self metricValueOfNodes: nodesToBeComputed.
	^ (toBeComputed / self metricValue) asFloat
]

{ #category : #visualizations }
CCTFunction >> visualizeFunction [
	| b |
	b := RTMondrian new.
	
	b shape box color: Color white; withTextAbove.
	b node: 'calling functions' forIt: [ 
		b shape box withTextAbove: #functionName.
		b nodes: self incomingFunctions forEach: [ 
			b shape box
				width: #max; height: #min.
			b nodes: cctNodes.
			b layout grid ].
		b layout verticalLine.
	].
	
	b shape box withTextAbove: functionName.
	b node: self forIt: [ 
		b shape box
			width: #max; height: #min.
		b nodes: cctNodes.
		b layout grid ].

	b shape box color: Color white; withTextAbove.
	b node: 'called functions' forIt: [ 
		b shape box withTextAbove: #functionName.
		b nodes: self outgoingFunctions forEach: [ 
			b shape box
				width: #max; height: #min.
			b nodes: cctNodes.
			b layout grid ].
		b layout verticalLine.
	].
	
	b layout horizontalLine alignCenter.
	
	b shape line
		withShorterDistanceAttachPoint;
		color: Color blue trans.
	b edges 
		objects: self incomingFunctions, self outgoingFunctions, (Array with: self);
		connectToAll: #outgoingFunctions.

	b normalizer normalizeLineWidth: [ :from :to | to shareOfFunction: from ].
	^ b
]
