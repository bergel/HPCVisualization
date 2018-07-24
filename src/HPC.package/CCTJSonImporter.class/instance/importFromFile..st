public - importing
importFromFile: aFilename
	"
	CCTJSonImporter new importFromFile: '/Users/alexandrebergel/Dropbox/GitRepos/HPCVisualization/data/zeusmp2_512_trace/zeusmp2_execution_fixed.json'.
	
	"
	
	^ self importFromString: aFilename asFileReference contents.
