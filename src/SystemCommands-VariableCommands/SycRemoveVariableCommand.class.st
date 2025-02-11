"
I am a command to remove given variables
"
Class {
	#name : #SycRemoveVariableCommand,
	#superclass : #SycRefactorVariableCommand,
	#category : #'SystemCommands-VariableCommands'
}

{ #category : #activation }
SycRemoveVariableCommand class >> sourceCodeMenuActivation [
	<classAnnotation>

	^SycSourceCodeMenuActivation byRootGroupItemOrder: 1.5 for: ClySourceCodeContext
]

{ #category : #execution }
SycRemoveVariableCommand >> asRefactorings [

	^self createRefactorings: RBRemoveInstanceVariableRefactoring
]

{ #category : #accessing }
SycRemoveVariableCommand >> defaultMenuIconName [
	^#removeIcon
]

{ #category : #accessing }
SycRemoveVariableCommand >> defaultMenuItemName [
	^'Remove'
]

{ #category : #testing }
SycRemoveVariableCommand >> isComplexRefactoring [

	^false
]

{ #category : #execution }
SycRemoveVariableCommand >> prepareFullExecutionInContext: aToolContext [
	| noUsers |
	super prepareFullExecutionInContext: aToolContext.

	noUsers := aToolContext confirmUnusedVariables: variables.
	noUsers ifFalse: [CmdCommandAborted signal]
]
