Class {
	#name : #CCTModel,
	#superclass : #Object,
	#instVars : [
		'ccts',
		'functions'
	],
	#category : 'HPC'
}

{ #category : #'public - adding' }
CCTModel >> addNode: aCCTNode [
	"Add a node to the model"
	^ ccts add: aCCTNode
]

{ #category : #'public - importing' }
CCTModel >> ensureConnection [
	"Connect all the nodes together"
	| parentNode |
	ccts copy
		do: [ :aCCt | 
			parentNode := ccts detect: [ :c | c id = aCCt parentId ] ifNone: [ nil ].
			parentNode
				ifNotNil: [ aCCt parent: parentNode.
					parentNode addChild: aCCt ] ].
			
	functions do: [ :f |
		| out |
		out := ((f nodes flatCollect: #children) collect: #function) asSet.
		out do: [ :ff | ff addIncomingFunction: f. f addOutgoingFunction: ff ].
	]
]

{ #category : #accessing }
CCTModel >> functions [
	"Return the functions contained in the model"
	^ functions 
]

{ #category : #accessing }
CCTModel >> getOrCreateFunctionNamed: aFunctionName [
	"Create a function with a particular name. If it does not exist, create it"
	| f |
	f := functions detect: [ :ff | ff functionName = aFunctionName ] ifNone: [ nil ].
	f ifNil: [ f := CCTFunction new functionName: aFunctionName. functions add: f].
	^ f
]

{ #category : #visualizations }
CCTModel >> gtInspectorCCTIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'CCT';
		initializeView: [ 
			self visualizeCCT  ]
]

{ #category : #visualizations }
CCTModel >> gtInspectorFunctionsIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'Functions';
		initializeView: [ 
			self visualizeFunctionGraph  ]
]

{ #category : #ui }
CCTModel >> gtInspectorGridIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'Grid';
		initializeView: [ 
			self visualizeTree  ]
]

{ #category : #visualizations }
CCTModel >> gtInspectorViewActiveProcessesIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'ActiveProcesses';
		initializeView: [ 
			self visualizeActiveProcesses  ]
]

{ #category : #visualizations }
CCTModel >> gtInspectorViewGroupOfContextsIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'GroupOfContexts';
		initializeView: [ | v |
			self visualizeGroupsOfContexts  ]
]

{ #category : #'public - importing' }
CCTModel >> importConnectionsFromFilename: aFullFilename [
"/Users/alexandrebergel/Desktop/connections.tsv "
	| ids |
	(aFullFilename asFileReference contents lines reject: #isEmpty) do: [ :aLine |
		| parent child |
		ids := aLine substrings collect: #asInteger.
		parent := ccts detect: [ :n | n id = ids first ].
		child := ccts detect: [ :n | n id = ids second ].
		parent addChild: child.
		child parent: parent.
	]
]

{ #category : #'public - importing' }
CCTModel >> importFilename: aFullFilename [
	"
	| m |
	m := CCTModel new.
	m importFilename: '/Users/alexandrebergel/Dropbox/GitRepos/HPCVisualization/data/cleanedTimeData.tsv'.
	m importConnectionsFromFilename: '/Users/alexandrebergel/Dropbox/GitRepos/HPCVisualization/data/connections.tsv'.
	m
	"

	| node |
	(aFullFilename asFileReference contents lines reject: #isEmpty)
		do: [ :aLine | 
			node := CCTNode new.
			node fromLine: aLine.
			self addNode: node ]
]

{ #category : #initialization }
CCTModel >> initialize [
	super initialize.
	ccts := OrderedCollection new.
	functions := OrderedCollection new
]

{ #category : #accessing }
CCTModel >> nodes [
	"Return the nodes contained in the model"
	^ ccts 
]

{ #category : #visualizations }
CCTModel >> visualizeActiveProcesses [
	| b lb |
	b := RTMondrian new.
	b nodes: (ccts reverseSortedAs: #numberOfProcesses).
	b layout grid.
	b normalizer
		normalizeSize: #numberOfProcesses;
		normalizeColor: #numberOfProcesses.
	b build.
	
	lb := RTLegendBuilder new.
	lb view: b view.
	lb addText: 'This visualizations indicates how CCT nodes crosscut computing nodes'.
	lb addText: 'Box = a calling context tree node'.
	lb addText: 'Box size = number of different computing nodes (e.g., CPU, Core) used by the CCT node'.
	lb addColorFadingFrom: Color gray to: Color red text: 'Number of computing nodes (gray = few processes, and red = many)'.
	lb build.
	
	^ b view
]

{ #category : #visualizations }
CCTModel >> visualizeCCT [
	| b lb |
	b := RTMondrian new.
	b shape box
		width: #max; height: #min.
	b nodes: ccts.
	b layout radial.
	b normalizer
		normalizeColor: #max;
		alphaColor: 0.4.
		
	b edges moveBehind; connectFrom: #parent.
	b build.
	
	lb := RTLegendBuilder new.
	lb view: b view.
	lb addText: 'Calling context tree'.
	lb addText: 'Box = a calling context tree node'.
	lb addText: 'Edge = calling / callee relation'.
	lb addText: 'Box width = Maximum values of the self time, across computational units'.
	lb addText: 'Box height = Minimum values of the self time, across computational units'.
	lb addText: 'Box color = Box width'.
	lb build.
	^ b view
]

{ #category : #visualizations }
CCTModel >> visualizeFunctionGraph [
	| b lb |
	b := RTMondrian new.
	b shape circle.
	b interaction highlightNeighbors: #outgoingFunctions color: Color green trans.
	b nodes: functions.
	b layout force.
	b normalizer
		normalizeColor: #numberOfNodes;
		normalizeSize: #numberOfNodes;
		alphaColor: 0.6.
		
	b shape line color: Color gray trans.
	b edges moveBehind; connectToAll: #outgoingFunctions.
	b build.
	
	lb := RTLegendBuilder new.
	lb view: b view.
	lb addText: 'Graph of functions invocations'.
	lb addText: 'Circle = a function'.
	lb addText: 'Circle size = color = number of CCT node corresponding to the function'.
	lb addText: 'Green circle = functions invoked by the selected function'.
	lb addText: 'Edge = call between function'.
	lb build.
	^ b view
]

{ #category : #visualizations }
CCTModel >> visualizeGroupsOfContexts [
	| b groupedByAssocs lb |
	groupedByAssocs := ccts groupedBy: #nodeName.
	b := RTMondrian new.
	b shape box withTextAbove: #key.
	b nodes: groupedByAssocs associations forEach: [ :assoc |
		b shape box
			width: #max; height: #min.
		b nodes: assoc value.
		b layout grid.
	].
	b layout grid.
	b build.

	lb := RTLegendBuilder new.
	lb view: b view.
	lb addText: 'This visualizations shows functions and their corresponding CCT nodes'.
	lb addText: 'Large Box = a function'.
	lb addText: 'Inner box = a calling context'.
	lb build.
	
	^ b view
]

{ #category : #ui }
CCTModel >> visualizeTree [
	| b lb |
	b := RTMondrian new.
	b shape box
		width: #max; height: #min.
	b nodes: ccts.
	b layout radial.
	b normalizer
		normalizeColor: #max;
		alphaColor: 0.4.
		
	b edges moveBehind; connectFrom: #parent.
	b build.
	
	lb := RTLegendBuilder new.
	lb view: b view.
	lb addText: 'Calling context tree'.
	lb addText: 'Box = a calling context tree node'.
	lb addText: 'Edge = calling / callee relation'.
	lb addText: 'Box width = Maximum values of the self time, across computational units'.
	lb addText: 'Box height = Minimum values of the self time, across computational units'.
	lb addText: 'Box color = Box width'.
	lb build.
	^ b view
]
