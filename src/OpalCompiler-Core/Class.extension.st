Extension { #name : #Class }

{ #category : #'*OpalCompiler-Core' }
Class >> classSideCompiler [
	"Redefine this method if you want to customize the compiler for class-side methods"
	^self classSideCompilerClass new
		environment: self classSide environment;
		class: self classSide
]

{ #category : #'*OpalCompiler-Core' }
Class >> classSideCompilerClass [
	"Redefine this method if you want to customize the compiler class for class-side methods"
	^ Smalltalk compilerClass
]
