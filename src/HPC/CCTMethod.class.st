"
I represent a method in the context of one messageTally
"
Class {
	#name : #CCTMethod,
	#superclass : #Object,
	#instVars : [
		'raw',
		'nodes',
		'incomingMethods',
		'outgoingMethods'
	],
	#category : #'HPC-messagetally'
}

{ #category : #accessing }
CCTMethod >> add: node [
	nodes ifNil: [ nodes := OrderedCollection new ].
	nodes add: node.
]

{ #category : #accessing }
CCTMethod >> addIncomingMethod: m [
	incomingMethods ifNil: [ incomingMethods := OrderedCollection new ].
	incomingMethods add: m
]

{ #category : #accessing }
CCTMethod >> addOutgoingMethod: m [
	outgoingMethods ifNil: [ outgoingMethods := OrderedCollection new ].
	outgoingMethods add: m
]

{ #category : #accessing }
CCTMethod >> incomingMethods [
	^ incomingMethods ifNil: [ #() ]
]

{ #category : #accessing }
CCTMethod >> nodes [
	^ nodes
]

{ #category : #accessing }
CCTMethod >> numberOfNodes [
	^ nodes size
]

{ #category : #accessing }
CCTMethod >> outgoingMethods [
	^ outgoingMethods ifNil: [ #() ].
]

{ #category : #accessing }
CCTMethod >> printOn: stream [
	raw printOn: stream
]

{ #category : #accessing }
CCTMethod >> raw [
	^ raw
]

{ #category : #accessing }
CCTMethod >> raw: aMethod [
	raw := aMethod
]
