visualizations
visualizeGroupsOfContexts
	| b groupedByAssocs lb |
	groupedByAssocs := ccts groupedBy: #nodeName.
	b := RTMondrian new.
	b shape box withTextAbove: #key.
	b nodes: groupedByAssocs associations forEach: [ :assoc |
		b shape box
			width: #max; height: #min.
		b nodes: assoc value.
		b layout grid.
	].
	b layout grid.
	b build.

	lb := RTLegendBuilder new.
	lb view: b view.
	lb addText: 'This visualizations shows functions and their corresponding CCT nodes'.
	lb addText: 'Large Box = a function'.
	lb addText: 'Inner box = a calling context'.
	lb build.
	
	^ b view