visualizations
visualizeFunction
	| b |
	b := RTMondrian new.
	
	b shape box color: Color white; withTextAbove.
	b node: 'calling functions' forIt: [ 
		b shape box withTextAbove: #functionName.
		b nodes: self incomingFunctions forEach: [ 
			b shape box
				width: #max; height: #min.
			b nodes: cctNodes.
			b layout grid ].
		b layout verticalLine.
	].
	
	b shape box withTextAbove: functionName.
	b node: self forIt: [ 
		b shape box
			width: #max; height: #min.
		b nodes: cctNodes.
		b layout grid ].

	b shape box color: Color white; withTextAbove.
	b node: 'called functions' forIt: [ 
		b shape box withTextAbove: #functionName.
		b nodes: self outgoingFunctions forEach: [ 
			b shape box
				width: #max; height: #min.
			b nodes: cctNodes.
			b layout grid ].
		b layout verticalLine.
	].
	
	b layout horizontalLine alignCenter.
	
	b shape line
		withShorterDistanceAttachPoint;
		color: Color blue trans.
	b edges 
		objects: self incomingFunctions, self outgoingFunctions, (Array with: self);
		connectToAll: #outgoingFunctions.
	^ b