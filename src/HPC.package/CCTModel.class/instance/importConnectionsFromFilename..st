public - importing
importConnectionsFromFilename: aFullFilename
"/Users/alexandrebergel/Desktop/connections.tsv "
	| ids |
	(aFullFilename asFileReference contents lines reject: #isEmpty) do: [ :aLine |
		| parent child |
		ids := aLine substrings collect: #asInteger.
		parent := ccts detect: [ :n | n id = ids first ].
		child := ccts detect: [ :n | n id = ids second ].
		parent addChild: child.
		child parent: parent.
	]