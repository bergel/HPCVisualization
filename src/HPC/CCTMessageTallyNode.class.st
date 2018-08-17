"
I represent a node of the model of MessageTally instance
"
Class {
	#name : #CCTMessageTallyNode,
	#superclass : #Object,
	#instVars : [
		'parent',
		'messageTally',
		'children',
		'method'
	],
	#category : #'HPC-messagetally'
}

{ #category : #accessing }
CCTMessageTallyNode >> add: aNode [
	children ifNil: [ children := OrderedCollection new ].
	children add: aNode.
]

{ #category : #accessing }
CCTMessageTallyNode >> children [
	^ children ifNil: [ #()  ]
]

{ #category : #accessing }
CCTMessageTallyNode >> messageTally [
	^ messageTally 
]

{ #category : #accessing }
CCTMessageTallyNode >> messageTally: aMessageTally [
	messageTally := aMessageTally
]

{ #category : #accessing }
CCTMessageTallyNode >> method [
	^ method
]

{ #category : #accessing }
CCTMessageTallyNode >> method: aCCTMethod [
	method := aCCTMethod
]

{ #category : #accessing }
CCTMessageTallyNode >> parent [
	^ parent
]

{ #category : #accessing }
CCTMessageTallyNode >> parent: aNode [
	parent := aNode
]

{ #category : #accessing }
CCTMessageTallyNode >> printOn: stream [
	messageTally method method printOn: stream.
]

{ #category : #accessing }
CCTMessageTallyNode >> tally [
	^ messageTally tally
]
