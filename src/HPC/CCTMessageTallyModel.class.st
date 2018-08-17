"
I represent a messageTally and it methods in this context

- message one   
- message two 
- (for bonus points) how to create instances.

Use CTTMessageTallyImporter
"
Class {
	#name : #CCTMessageTallyModel,
	#superclass : #Object,
	#instVars : [
		'root',
		'methods'
	],
	#category : #'HPC-messagetally'
}

{ #category : #adding }
CCTMessageTallyModel >> add: aRootNode [
	"CCTMessageTallyNode"
	root := aRootNode
]

{ #category : #private }
CCTMessageTallyModel >> ensureConnection [
	self methods do: [ :m | | out |
		out := ((m nodes flatCollect: #children) collect: #method) asSet.
		out do: [ :m2 | 
			m2 addIncomingMethod: m.
			m addOutgoingMethod: m2 ] ].
]

{ #category : #accessing }
CCTMessageTallyModel >> fill: nodes with: node [
	nodes add: node.
	node children do: [ :child | self fill: nodes with: child ].
]

{ #category : #computing }
CCTMessageTallyModel >> getOrCreateMethod: method [
	^ methods at: method ifAbsentPut: [ CCTMethod new raw: method ].
]

{ #category : #ui }
CCTMessageTallyModel >> gtCCT: composite [
	<gtInspectorPresentationOrder: -30>
	composite roassal2
		title: 'CCT';
		initializeView: [ self visualizeCCT ]
]

{ #category : #ui }
CCTMessageTallyModel >> gtMethods: composite [
	<gtInspectorPresentationOrder: -20>
	composite roassal2
		title: 'Methods';
		initializeView: [ self visualizeMethods ]
]

{ #category : #initialization }
CCTMessageTallyModel >> initialize [
	super initialize.
	methods := Dictionary new.
]

{ #category : #accessing }
CCTMessageTallyModel >> methods [
	^ methods asArray
]

{ #category : #accessing }
CCTMessageTallyModel >> nodes [
	| nodes |
	nodes := OrderedCollection new.
	self fill: nodes with: root.
	^ nodes
]

{ #category : #adding }
CCTMessageTallyModel >> root [
	^ root
]

{ #category : #visualizations }
CCTMessageTallyModel >> visualizeCCT [
	| b lb |
	b := RTMondrian new.
	b shape ellipse
		size: #tally.
	b nodes: self nodes.
	b layout radial.
	b normalizer
		normalizeColor: #tally;
		alphaColor: 0.4.
	b edges 
		moveBehind;
		connectFrom: #parent.
	b build.
	lb := RTLegendBuilder new.
	lb view: b view.
	lb 
		addText: 'Calling context tree';
		addText: 'Radius of each node is the tally'.
	
	lb build.
	^b view.
	

]

{ #category : #visualizations }
CCTMessageTallyModel >> visualizeMethods [
	| b lb |
	b := RTMondrian new.
	b shape ellipse.
	b interaction highlightNeighbors: #outgoingMethods color: Color green trans.
	b nodes: self methods.
	b layout force.
	b normalizer
		normalizeColor: #numberOfNodes;
		normalizeSize: #numberOfNodes;
		alphaColor: 0.6.
	b shape line color: Color gray trans.
	b edges 
		moveBehind;
		connectToAll: #outgoingMethods.
	b build.
	lb := RTLegendBuilder new.
	lb view: b view.
	lb 
		addText: 'Graph of method invocations';
		addText: 'Circle = a method';
		addText: 'Circle size, color = size of nodes that uses that method';
		addText: 'Green circle = methods invoked by the selected function';
		addText: 'Edge = call between methods'.
	
	lb build.
	^ b view.
	

]
