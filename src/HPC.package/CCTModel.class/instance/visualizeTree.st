ui
visualizeTree
	| b lb |
	b := RTMondrian new.
	b shape box
		width: #max; height: #min.
	b nodes: ccts.
	b layout radial.
	b normalizer
		normalizeColor: #max;
		alphaColor: 0.4.
		
	b edges moveBehind; connectFrom: #parent.
	b build.
	
	lb := RTLegendBuilder new.
	lb view: b view.
	lb addText: 'Calling context tree'.
	lb addText: 'Box = a calling context tree node'.
	lb addText: 'Edge = calling / callee relation'.
	lb addText: 'Box width = Maximum values of the self time, across computational units'.
	lb addText: 'Box height = Minimum values of the self time, across computational units'.
	lb addText: 'Box color = Box width'.
	lb build.
	^ b view