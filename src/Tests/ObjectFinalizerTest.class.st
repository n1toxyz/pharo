Class {
	#name : #ObjectFinalizerTest,
	#superclass : #TestCase,
	#category : #'Tests-Finalization'
}

{ #category : #tests }
ObjectFinalizerTest >> testFinalizationOfMultipleResources [
	"Test that finalizers for multiple resources registered will be ran when
	object is finalized"
	| objToFinalize resource1 resource2 resourceCleanBlock |
	objToFinalize := Object new.
	resource1 := Array with: false.
	resource2 := Array with: false.
	resourceCleanBlock := [:array | array at: 1 put: true].
	objToFinalize
		toFinalizeSend: #value:
		to: resourceCleanBlock
		with: resource1.
	objToFinalize
		toFinalizeSend: #value:
		to: resourceCleanBlock
		with: resource2.
	self deny: resource1 first.
	self deny: resource2 first.
	"Trigger finalization"
	objToFinalize := nil.

	"Many finalizers on the same object are triggered one at a time.
	When the GC triggers one finalizer, the reference becomes strong and it cannot trigger the second one.
	=> Run two GCs to trigger both finalizers."
	Smalltalk garbageCollect.
	Smalltalk garbageCollect.
	self assert: resource1 first.
	self assert: resource2 first
]
