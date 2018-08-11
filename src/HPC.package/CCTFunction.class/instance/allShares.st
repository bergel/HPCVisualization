public - computing share
allShares
	"Return the list of ratio of execution time for the incoming functions call"
	^ incomingFunctions collect: [ :f | self shareOfFunction: f ]