metrics
numberOfProcesses
	^ (self metrics reject: [ :value | value = 0 ]) size