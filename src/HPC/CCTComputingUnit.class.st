Class {
	#name : #CCTComputingUnit,
	#superclass : #Object,
	#instVars : [
		'id',
		'ccts'
	],
	#category : #HPC
}

{ #category : #accessing }
CCTComputingUnit >> average [
	^ self values average
]

{ #category : #accessing }
CCTComputingUnit >> ccts [
	^ ccts
]

{ #category : #accessing }
CCTComputingUnit >> ccts: aCollectionOfCCTNodes [
	ccts := aCollectionOfCCTNodes
]

{ #category : #accessing }
CCTComputingUnit >> id [
	^ id
]

{ #category : #accessing }
CCTComputingUnit >> id: aNumber [
	id := aNumber
]

{ #category : #accessing }
CCTComputingUnit >> max [
	^ self values max
]

{ #category : #accessing }
CCTComputingUnit >> min [
	^ self values min
]

{ #category : #accessing }
CCTComputingUnit >> values [
	"Return the values corresponding to my node"
	^ ccts collect: [ :node | node metrics at: id ]
]
