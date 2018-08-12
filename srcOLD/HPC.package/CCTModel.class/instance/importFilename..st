public - importing
importFilename: aFullFilename
	"
	| m |
	m := CCTModel new.
	m importFilename: '/Users/alexandrebergel/Dropbox/GitRepos/HPCVisualization/data/cleanedTimeData.tsv'.
	m importConnectionsFromFilename: '/Users/alexandrebergel/Dropbox/GitRepos/HPCVisualization/data/connections.tsv'.
	m
	"

	| node |
	(aFullFilename asFileReference contents lines reject: #isEmpty)
		do: [ :aLine | 
			node := CCTNode new.
			node fromLine: aLine.
			self addNode: node ]