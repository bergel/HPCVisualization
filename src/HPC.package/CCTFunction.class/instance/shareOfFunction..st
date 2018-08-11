public - computing share
shareOfFunction: aFunction
	"Return the ratio of my execution time with the incoming function provided as argument"
	
	"We get the nodes that have the method argument as parent function"
	| nodesToBeComputed toBeComputed total |
	nodesToBeComputed := cctNodes select: [ :aNode | aNode parent function == aFunction ].
	toBeComputed := self metricValueOfNodes: nodesToBeComputed.
	^ (toBeComputed / self metricValue) asFloat