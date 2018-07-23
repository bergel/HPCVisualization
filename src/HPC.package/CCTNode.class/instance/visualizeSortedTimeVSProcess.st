visualizations
visualizeSortedTimeVSProcess
	| g d |
	g := RTGrapher new.
	d := RTData new.
	d samplingIfMoreThan: 5000.
	d dotShape color: Color blue trans; size: 4.
	d points: (self metrics reverseSortedAs: #yourself).
	d y: #yourself.
	g add: d.
	g axisX
		title: 'Process id';
		noDecimal.
	g axisY title: 'Execution time'.
	^ g