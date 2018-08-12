printing
printOn: str
	str nextPut: $<.
	str nextPutAll: self id asString.
	str nextPut: $,.
	str nextPutAll: self nodeName.
	str nextPut: $>.