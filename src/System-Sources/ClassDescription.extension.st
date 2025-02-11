Extension { #name : #ClassDescription }

{ #category : #'*System-Sources' }
ClassDescription >> logMethodSource: aText forMethod: aCompiledMethod inCategory: category withStamp: changeStamp [
	aCompiledMethod
		putSource: aText
		class: self
		category: category
		withStamp: changeStamp
		priorMethod: (self
					compiledMethodAt: aCompiledMethod selector
					ifAbsent: [])
]
