"
I'm a unix platform (works in mac too) dynamic library loader.
"
Class {
	#name : #UnixDynamicLoader,
	#superclass : #DynamicLoader,
	#classVars : [
		'RTLD_LAZY',
		'RTLD_NOW'
	],
	#category : #'UnifiedFFI-Libraries'
}

{ #category : #'class initialization' }
UnixDynamicLoader class >> initialize [

	"flags for dlopen"
	RTLD_LAZY := 1.
	RTLD_NOW := 2
]

{ #category : #testing }
UnixDynamicLoader class >> isAvailable [
	^ Smalltalk os isUnix
		or: [ Smalltalk os isMacOS ]
]

{ #category : #misc }
UnixDynamicLoader >> lastError [
	^ self ffiCall: #(String dlerror(void))
]

{ #category : #misc }
UnixDynamicLoader >> loadLibrary: path [

	^ self loadLibrary: path flag: RTLD_LAZY
]

{ #category : #misc }
UnixDynamicLoader >> loadLibrary: filename flag: flag [
	"
	Flags can be:
	RTLD_LAZY = 1
	RTLD_NOW = 2
	"

	^ self ffiCall: #(void *dlopen(const char *filename, int flag))
]

{ #category : #misc }
UnixDynamicLoader >> loadSymbolFrom: handle name: symbol [
	^ self ffiCall: #(void *dlsym(void *handle, String symbol))
]
