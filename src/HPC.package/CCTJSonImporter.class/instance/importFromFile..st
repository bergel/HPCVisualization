public - importing
importFromFile: aFilename
	"
	CCTJSonImporter new importFromFile: '/Users/alexandrebergel/Dropbox/GitRepos/HPCVisualization/data/zeusmp2_512_trace/zeusmp2_execution_fixed.json'.
	
	"
	
	| rawData cnodes m node |
	rawData := NeoJSONReader fromString: aFilename asFileReference contents.
	cnodes := (rawData at: 'metrics') first at: 'cnodes'.
	
	m := CCTModel new.
	cnodes do: [ :dict |
		node := CCTNode new.
		node id: (dict at: 'id') asInteger.
		node regionId: (dict at: 'region_id') asInteger.
		node nodeName: (dict at: 'region_name').
		node parentId: (dict at: 'parent_id') asInteger.
		node metrics: ((dict at: 'location_data') collect: [ :vv | Float readFrom: vv ]).
		m addNode: node.
	].

	m ensureConnection.
	^ m