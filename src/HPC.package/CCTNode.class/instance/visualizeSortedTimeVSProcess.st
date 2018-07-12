as yet unclassified
visualizeSortedTimeVSProcess
	| g d |
	g := RTGrapher new.
	d := RTData new.
	d points: (self metrics reverseSortedAs: #yourself).
	d y: #yourself.
	g add: d.
	g axisX
		title: 'Process id';
		noDecimal.
	g axisY title: 'Execution time'.
	^ g