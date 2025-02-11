"
TEquality is a trait that provides a generic implementation for = and hash.
It aims avoiding to implement = and hash for simple cases.
To make instances of some class comparable, simply make the class use this trait.

TEquality relies on message valuesToCompareForEquality sent to objects for both = and hash.
The default implmentation of this message is provided by Object.
Override ONLY valuesToCompareForEquality method for custom equality check.

Examples:
You can find examples in the `#'Equals-Tests'` package.
```Smalltalk
Object << #EqPerson
	trait: TEquality;
	slots: { #name . #age };
	package: 'Equals-Tests'
```
"
Trait {
	#name : #TEquality,
	#category : #Equals
}

{ #category : #comparing }
TEquality >> = anObject [ 
	self species = anObject species ifFalse: [^false].
	^self valuesToCompareForEquality = anObject valuesToCompareForEquality
]

{ #category : #comparing }
TEquality >> hash [
	^self valuesToCompareForEquality inject: self species hash into: [:hash :comparisonValue|
		(hash bitXor: comparisonValue hash) hashMultiply]

]
