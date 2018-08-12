public - importing
ensureConnection
	| parentNode |
	ccts copy
		do: [ :aCCt | 
			parentNode := ccts detect: [ :c | c id = aCCt parentId ] ifNone: [ nil ].
			parentNode
				ifNotNil: [ aCCt parent: parentNode.
					parentNode addChild: aCCt ] ]