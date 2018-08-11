accessing
metricValueOfNodes: someCCTNodes
	"This method return a value describing the performance. The definition should probably be improved in the future"
	^ (someCCTNodes collect: [ :n | n metrics average ]) sum.