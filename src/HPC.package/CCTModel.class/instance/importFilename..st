public - importing
importFilename: aFullFilename

	"
	| m |
	m := CCTModel new.
	m importFilename: '/Users/alexandrebergel/Desktop/cleanedTimeData.tsv'.
	m importConnectionsFromFilename: '/Users/alexandrebergel/Desktop/connections.tsv'.
	m
	"

	| node |
	(aFullFilename asFileReference contents lines reject: #isEmpty) do: [ :aLine |
		node := CCTNode new.
		node fromLine: aLine.
		ccts add: node
	]