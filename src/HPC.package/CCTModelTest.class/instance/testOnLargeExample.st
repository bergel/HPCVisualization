tests
testOnLargeExample

	| m |
	m := CCTJSonImporter new importFromString: self exampleZeusReady.
	self assert: (m isKindOf: CCTModel).
	m visualizeCCT; visualizeActiveProcesses; visualizeGroupsOfContexts.
	m nodes first visualizeSortedTimeVSProcess; visualizeTimeVSProcess; stdev; average; printString; regionId.
	self assert: m nodes first children notEmpty