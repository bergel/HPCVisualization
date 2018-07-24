accessing
getOrCreateFunctionNamed: aFunctionName
	"Create a function with a particular name. If it does not exist, create it"
	| f |
	f := functions detect: [ :ff | ff functionName = aFunctionName ] ifNone: [ nil ].
	f ifNil: [ f := CCTFunction new functionName: aFunctionName. functions add: f].
	^ f