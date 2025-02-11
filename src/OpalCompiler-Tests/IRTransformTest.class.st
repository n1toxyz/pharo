Class {
	#name : #IRTransformTest,
	#superclass : #TestCase,
	#category : #'OpalCompiler-Tests-IR'
}

{ #category : #'tests - adding' }
IRTransformTest >> testAdd [
	| iRMethod aCompiledMethod |
	iRMethod := IRBuilder new
		pushLiteral: 1;
		returnTop;
		ir.
	iRMethod allSequences last last delete.
	iRMethod allSequences last last delete.
	iRMethod allSequences last add: (IRInstruction pushLiteral: 2).
	iRMethod allSequences last add: IRInstruction returnTop.
	aCompiledMethod := iRMethod compiledMethod.
	self
		assert: (aCompiledMethod valueWithReceiver: nil arguments: #())
		equals: 2
]

{ #category : #'tests - adding' }
IRTransformTest >> testAddBefore [
	| iRMethod aCompiledMethod ret |
	iRMethod := IRBuilder new
		pushLiteral: 1;
		returnTop;
		ir.
	iRMethod allSequences last last delete.
	iRMethod allSequences last last delete.
	ret := IRInstruction returnTop.
	iRMethod allSequences last add: ret.
	iRMethod allSequences last
		add: (IRInstruction pushLiteral: 2)
		before: ret.
	aCompiledMethod := iRMethod compiledMethod.
	self
		assert: (aCompiledMethod valueWithReceiver: nil arguments: #())
		equals: 2
]

{ #category : #'tests - adding' }
IRTransformTest >> testAddIntructions [
	| iRMethod aCompiledMethod |
	iRMethod := IRBuilder new
		pushLiteral: 1;
		returnTop;
		ir.
	iRMethod allSequences last last delete.
	iRMethod allSequences last last delete.
	iRMethod allSequences last
		addInstructions:
			{(IRInstruction pushLiteral: 2).
			IRInstruction returnTop}.
	aCompiledMethod := iRMethod compiledMethod.
	self
		assert: (aCompiledMethod valueWithReceiver: nil arguments: #())
		equals: 2
]

{ #category : #'tests - adding' }
IRTransformTest >> testAddIntructionsBefore [
	| iRMethod aCompiledMethod push |
	iRMethod := IRBuilder new
		pushLiteral: 1;
		returnTop;
		ir.
	push := iRMethod allSequences last first.
	iRMethod allSequences last
		addInstructions:
			{(IRInstruction pushLiteral: 2).
			IRInstruction returnTop}
		before: push.
	aCompiledMethod := iRMethod compiledMethod.
	self
		assert: (aCompiledMethod valueWithReceiver: nil arguments: #())
		equals: 2
]

{ #category : #'tests - adding' }
IRTransformTest >> testAddIntructionsBeforeFromLList [
	| iRMethod aCompiledMethod push llist col |
	iRMethod := IRBuilder new
		pushLiteral: 1;
		returnTop;
		ir.
	push := iRMethod allSequences last at: 1.
	llist := LinkedList new.
	llist add: (IRInstruction pushLiteral: 2).
	llist add: IRInstruction returnTop.
	col := llist asOrderedCollection.
	iRMethod allSequences last addInstructions: col before: push.
	aCompiledMethod := iRMethod compiledMethod.
	self
		assert: (aCompiledMethod valueWithReceiver: nil arguments: #())
		equals: 2
]

{ #category : #'tests - enumeration' }
IRTransformTest >> testAllInstructions [
		| ir |

		ir := IRBuilderTest new testPushTempTemp.
		self assert: ir allInstructions last isReturn
]

{ #category : #'tests - enumeration' }
IRTransformTest >> testAllTempAccessInstructions [
	| ir |
	ir := IRBuilderTest new testPushTempTemp.
	self assert: ir allTempAccessInstructions size equals: 1
]

{ #category : #'tests - adding' }
IRTransformTest >> testDelete [
	| iRMethod aCompiledMethod |
	iRMethod := IRBuilder new
		pushLiteral: 1;
		pushLiteral: 2;
		returnTop;
		ir.
	(iRMethod allSequences last
		detect: [ :each | each isPushLiteral: [ :c | c == 2 ] ]) delete.
	aCompiledMethod := iRMethod compiledMethod.
	self
		assert: (aCompiledMethod valueWithReceiver: nil arguments: #())
		equals: 1
]

{ #category : #'tests - adding' }
IRTransformTest >> testReplace [
	| iRMethod aCompiledMethod |
	iRMethod := IRBuilder new
		pushLiteral: 1;
		returnTop;
		ir.
	iRMethod allSequences last first
		replaceWith: (IRInstruction pushLiteral: 2).
	aCompiledMethod := iRMethod compiledMethod.
	self
		assert: (aCompiledMethod valueWithReceiver: nil arguments: #())
		equals: 2
]

{ #category : #'tests - adding' }
IRTransformTest >> testReplaceInstr [
	| iRMethod aCompiledMethod |
	iRMethod := IRBuilder new
		pushLiteral: 1;
		returnTop;
		ir.
	iRMethod allSequences last first
		replaceWithInstructions: {(IRInstruction pushLiteral: 2)}.
	aCompiledMethod := iRMethod compiledMethod.
	self
		assert: (aCompiledMethod valueWithReceiver: nil arguments: #())
		equals: 2
]
