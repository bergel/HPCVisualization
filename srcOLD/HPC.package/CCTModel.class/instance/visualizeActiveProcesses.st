ui
visualizeActiveProcesses
	| b lb |
	b := RTMondrian new.
	b nodes: (ccts reverseSortedAs: #numberOfProcesses).
	b layout grid.
	b normalizer
		normalizeSize: #numberOfProcesses;
		normalizeColor: #numberOfProcesses.
	b build.
	
	lb := RTLegendBuilder new.
	lb view: b view.
	lb addText: 'This visualizations indicates how CCT nodes crosscut computing nodes'.
	lb addText: 'Box = a calling context tree node'.
	lb addText: 'Box size = number of different computing nodes (e.g., CPU, Core) used by the CCT node'.
	lb addColorFadingFrom: Color gray to: Color red text: 'Number of computing nodes (gray = few processes, and red = many)'.
	lb build.
	
	^ b view