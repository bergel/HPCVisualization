Class {
	#name : #CCTNode,
	#superclass : #Object,
	#instVars : [
		'id',
		'nodeName',
		'metrics',
		'parent',
		'parentId',
		'children',
		'regionId',
		'function'
	],
	#category : 'HPC'
}

{ #category : #adding }
CCTNode >> addChild: aNode [
	"Add a child node. I am therefore the parent of the argument"
	children add: aNode
]

{ #category : #metrics }
CCTNode >> average [
	^ self metrics average
]

{ #category : #accessing }
CCTNode >> children [
	^ children
]

{ #category : #'instance creation' }
CCTNode >> fromLine: aString [
	| elements firstElemet |
	elements := aString substrings: ' '.
	firstElemet := elements first substrings: '()='.
	nodeName := firstElemet first.
	id := firstElemet last asInteger.
	metrics := elements allButFirst collect: [ :numberAsString | Float readFrom: numberAsString ].
	
]

{ #category : #accessing }
CCTNode >> function [
	"Return the function of the node"
	^ function
]

{ #category : #accessing }
CCTNode >> function: aCCTFunction [
	"Set the function of the node"
	function := aCCTFunction 
]

{ #category : #visualizations }
CCTNode >> gtInspectorGroupIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'Function';
		initializeView: [ | v |
			function visualizeFunction  ]
]

{ #category : #visualizations }
CCTNode >> gtInspectorView2In: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'SortedExTimeVSProcess';
		initializeView: [ | v |
			self visualizeSortedTimeVSProcess  ]
]

{ #category : #visualizations }
CCTNode >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'ExTimeVSProcess';
		initializeView: [ | v |
			self visualizeTimeVSProcess  ]
]

{ #category : #accessing }
CCTNode >> id [
	^ id
]

{ #category : #accessing }
CCTNode >> id: anInteger [
	id := anInteger
]

{ #category : #initialization }
CCTNode >> initialize [
	super initialize.
	id := -1.
	nodeName := 'NONAME'.
	metrics := OrderedCollection new.
	
	parent := -1.
	children := OrderedCollection new.
	
]

{ #category : #metrics }
CCTNode >> max [
	^ self metrics max
]

{ #category : #accessing }
CCTNode >> metrics [
	^ metrics
]

{ #category : #accessing }
CCTNode >> metrics: someMetrics [
	self assert: [ someMetrics isCollection ].
	self assert: [ someMetrics allSatisfy: #isFloat ].
	metrics := someMetrics 
]

{ #category : #metrics }
CCTNode >> min [
	^ self metrics min
]

{ #category : #accessing }
CCTNode >> nodeName [
	^ nodeName
]

{ #category : #accessing }
CCTNode >> nodeName: anObject [
	nodeName := anObject
]

{ #category : #metrics }
CCTNode >> numberOfProcesses [
	^ (self metrics reject: [ :value | value = 0 ]) size
]

{ #category : #accessing }
CCTNode >> parent [
	^ parent
]

{ #category : #accessing }
CCTNode >> parent: anInteger [
	parent := anInteger
]

{ #category : #accessing }
CCTNode >> parentId [
	^ parentId
]

{ #category : #accessing }
CCTNode >> parentId: anInteger [
	parentId := anInteger
]

{ #category : #printing }
CCTNode >> printOn: str [
	str nextPut: $<.
	str nextPutAll: self id asString.
	str nextPut: $,.
	str nextPutAll: self nodeName.
	str nextPut: $>.
]

{ #category : #accessing }
CCTNode >> regionId [
	^ regionId
]

{ #category : #accessing }
CCTNode >> regionId: anInteger [
	regionId := anInteger
]

{ #category : #metrics }
CCTNode >> stdev [
	^ self metrics stdev
]

{ #category : #visualizations }
CCTNode >> visualizeSortedTimeVSProcess [
	| g d |
	g := RTGrapher new.
	d := RTData new.
	d samplingIfMoreThan: 5000.
	d dotShape color: Color blue trans; size: 4.
	d points: (self metrics reverseSortedAs: #yourself).
	d y: #yourself.
	g add: d.
	g axisX
		title: 'Process id';
		noDecimal.
	g axisY title: 'Execution time'.
	^ g
]

{ #category : #visualizations }
CCTNode >> visualizeTimeVSProcess [
	| g d |
	g := RTGrapher new.
	d := RTData new.
	d samplingIfMoreThan: 5000.
	d dotShape color: Color blue trans; size: 4.
	d points: self metrics.
	d y: #yourself.
	g add: d.
	g axisX
		title: 'Process id';
		noDecimal.
	g axisY title: 'Execution time'.
	^ g
]
