ui
visualizeTree
	| b |
	b := RTMondrian new.
	b shape box
		width: #max; height: #min.
	b nodes: ccts.
	b layout radial.
	b normalizer
		normalizeColor: #max;
		alphaColor: 0.4.
		
	b edges moveBehind; connectFrom: #parent.
	^ b