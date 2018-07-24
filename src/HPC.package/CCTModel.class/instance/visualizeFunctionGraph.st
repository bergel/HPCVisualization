visualizations
visualizeFunctionGraph
	| b lb |
	b := RTMondrian new.
	b shape circle.
	b interaction highlightNeighbors: #outgoingFunctions color: Color green trans.
	b nodes: functions.
	b layout force.
	b normalizer
		normalizeColor: #numberOfNodes;
		normalizeSize: #numberOfNodes;
		alphaColor: 0.6.
		
	b shape line color: Color gray trans.
	b edges moveBehind; connectToAll: #outgoingFunctions.
	b build.
	
	lb := RTLegendBuilder new.
	lb view: b view.
	lb addText: 'Graph of functions invocations'.
	lb addText: 'Circle = a function'.
	lb addText: 'Circle size = color = number of CCT node corresponding to the function'.
	lb addText: 'Green circle = functions invoked by the selected function'.
	lb addText: 'Edge = call between function'.
	lb build.
	^ b view