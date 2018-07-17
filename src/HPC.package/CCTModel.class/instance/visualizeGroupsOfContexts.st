ui
visualizeGroupsOfContexts
	| b groupedByAssocs |
	groupedByAssocs := ccts groupedBy: #nodeName.
	b := RTMondrian new.
	b nodes: groupedByAssocs associations forEach: [ :assoc |
		b shape box
			width: #max; height: #min.
		b nodes: assoc value.
		b layout grid.
	].
	b layout grid.
	^ b