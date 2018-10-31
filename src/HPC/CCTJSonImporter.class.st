Class {
	#name : #CCTJSonImporter,
	#superclass : #Object,
	#category : 'HPC'
}

{ #category : #'public - importing' }
CCTJSonImporter >> importFromFile: aFilename [
	<script: '(CCTJSonImporter new importFromFile: ''/Users/alexandrebergel/Dropbox/GitRepos/HPCVisualization/data/zeusmp2_512_trace/zeusmp2_execution_fixed.json'') inspect'>
	"
	CCTJSonImporter new importFromFile: '/Users/alexandrebergel/Dropbox/GitRepos/HPCVisualization/data/zeusmp2_512_trace/zeusmp2_execution_fixed.json'.
	
	"
	
	^ self importFromString: aFilename asFileReference contents.

]

{ #category : #'public - importing' }
CCTJSonImporter >> importFromString: aString [
	"
	CCTJSonImporter new importFromFile: '/Users/alexandrebergel/Dropbox/GitRepos/HPCVisualization/data/zeusmp2_512_trace/zeusmp2_execution_fixed.json'.
	
	"
	
	| rawData cnodes m node function numberOfComputingUnits |
	rawData := NeoJSONReader fromString: aString.
	cnodes := (rawData at: 'metrics') first at: 'cnodes'.
	
	m := CCTModel new.
	cnodes do: [ :dict |
		| nodeName |
		nodeName := dict at: 'region_name'.
		node := CCTNode new.
		node id: (dict at: 'id') asInteger.
		node regionId: (dict at: 'region_id') asInteger.
		node nodeName: nodeName.
		node parentId: (dict at: 'parent_id') asInteger.
		node metrics: ((dict at: 'location_data') collect: [ :vv | Float readFrom: vv ]).
		
		function := m getOrCreateFunctionNamed: nodeName.
		node function: function.
		function addNode: node.
		m addNode: node.
	].


	numberOfComputingUnits := m nodes first metrics size.
	1 to: numberOfComputingUnits do: [ :i |
		| cu |
		cu := CCTComputingUnit new id: i; yourself.
		
		"Not sure whether this is important"
		cu ccts: m nodes.
		m addComputingUnit: cu
	].
	
	m ensureConnection.
	^ m
]
