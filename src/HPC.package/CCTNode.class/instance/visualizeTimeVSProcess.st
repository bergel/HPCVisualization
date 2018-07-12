as yet unclassified
visualizeTimeVSProcess
	| g d |
	g := RTGrapher new.
	d := RTData new.
	d points: self metrics.
	d y: #yourself.
	g add: d.
	g axisX
		title: 'Process id';
		noDecimal.
	g axisY title: 'Execution time'.
	^ g