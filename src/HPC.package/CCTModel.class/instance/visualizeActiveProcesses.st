as yet unclassified
visualizeActiveProcesses
	| b |
	b := RTMondrian new.
	b nodes: (ccts reverseSortedAs: #numberOfProcesses).
	b layout grid.
	b normalizer
		normalizeSize: #numberOfProcesses;
		normalizeColor: #numberOfProcesses.
	^ b