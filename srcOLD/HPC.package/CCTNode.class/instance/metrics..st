accessing
metrics: someMetrics
	self assert: [ someMetrics isCollection ].
	self assert: [ someMetrics allSatisfy: #isFloat ].
	metrics := someMetrics 