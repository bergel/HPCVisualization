as yet unclassified
visualizeNotNormalizedGrid
	| b |
	b := RTMondrian new.
	b shape box
		width: #max; height: #min.
	b nodes: ccts.
	b layout radial.
	b normalizer
		normalizeColor: #max.
		
	b edges connectFrom: #parent.
	^ b