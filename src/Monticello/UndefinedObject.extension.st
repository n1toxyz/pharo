Extension { #name : #UndefinedObject }

{ #category : #'*Monticello' }
UndefinedObject >> mcType [
	"Answer the symbol that Monticello uses internally to encode layouts"
	"Implemented here  to support disjoint class hierarchies"
	^#normal
]
