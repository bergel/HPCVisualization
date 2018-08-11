public - importing
ensureConnection
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