as yet unclassified
visualizeGrid
	| b |
	b := RTMondrian new.
	b nodes: ccts.
	b layout grid.
	b normalizer
		normalizeWidth: #max;
		normalizeHeight: #min;
		normalizeColor: #max.
	^ b