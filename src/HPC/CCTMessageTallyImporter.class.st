"
I am the importer equivalent of CCTJSonImporter
"
Class {
	#name : #CCTMessageTallyImporter,
	#superclass : #Object,
	#category : #'HPC-messagetally'
}

{ #category : #examples }
CCTMessageTallyImporter class >> example01 [
	(self new importFromMessageTally: (MessageTally 
		on: [ RTBoxPlotExample new exampleMethodDistribution build ])) inspect
]

{ #category : #'public - importing' }
CCTMessageTallyImporter >> importFrom: messageTally on: parent root: model [
	| node method |
	node := CCTMessageTallyNode new
		parent: parent;
		messageTally: messageTally.
	parent add: node.
	method := model getOrCreateMethod: messageTally method.
	node method: method.
	method add: node.
	messageTally children do: [ :m |
		self importFrom: m on: node  root: model ].
]

{ #category : #'public - importing' }
CCTMessageTallyImporter >> importFromMessageTally: messageTally [
	| m |
	m := CCTMessageTallyModel new.
	self importFrom: messageTally on: m root: m.
	m ensureConnection. 
	^ m
]
