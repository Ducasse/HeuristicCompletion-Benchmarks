"
```

CooBenchRunner new
	package: SpPresenter package;
	baseline: #classNamesWithoutPackageScope;
	others: { #classNamesWithPackageScope };
	run.
	
```
"
Class {
	#name : 'CooBenchRunner',
	#superclass : 'Object',
	#instVars : [
		'package',
		'baseline',
		'others',
		'results'
	],
	#category : 'ExtendedHeuristicCompletion-Benchmarks',
	#package : 'ExtendedHeuristicCompletion-Benchmarks'
}

{ #category : 'examples' }
CooBenchRunner class >> runMessageOnNeCompletionPackage [
	<script>
	
	^ (CooStaticBenchmarksMessage 
			runOnPackage: (PackageOrganizer default packageNamed: 'NECompletion')
			heuristics: [:b | b]) inspect. 
]

{ #category : 'examples' }
CooBenchRunner class >> runVariableOnNeCompletionPackage [
	<script>
	
	^ (CooStaticBenchmarksVariables 
			runOnPackage: (PackageOrganizer default packageNamed: 'NECompletion')
			heuristics: [:b | b]) inspect. 
]

{ #category : 'accessing' }
CooBenchRunner >> baseline: aSymbol [

	baseline := aSymbol 
]

{ #category : 'accessing' }
CooBenchRunner >> classNamesWithPackageScope [
	"self new 
		package: AnalyserData1 package;
		classNamesWithPackageScope"

	| builder benchmark |
	builder := CoASTHeuristicsResultSetBuilder new.
	builder variablesHeuristic:
						(builder newHeuristicBuilder
			      				add: CoLocalScopeVariablesHeuristic new;
			                add: CoWorkspaceVariablesHeuristic new;
			                add: CoInstanceAccessibleVariablesHeuristic new;
			                add: (CoGlobalVariablesHeuristic new
					                         globalVariableFetcherClass:
						                         CoPackageScopedGlobalVariableFetcher);
			                build).
	benchmark := (CooStaticBenchmarksVariables new
		name: 'Scoped Global';
		scope: (CoBenchmarkPackage on: package);
		builder: builder;
		run).
	benchmark inspect.
	^ benchmark

]

{ #category : 'accessing' }
CooBenchRunner >> classNamesWithoutPackageScope [
	"self new 
		package: AnalyserData1 package;
		classNamesWithoutPackageScope"

	| builder benchmark |
	builder := CoASTHeuristicsResultSetBuilder new.
	builder variablesHeuristic:
						(builder newHeuristicBuilder
			      				add: CoLocalScopeVariablesHeuristic new;
			                add: CoWorkspaceVariablesHeuristic new;
			                add: CoInstanceAccessibleVariablesHeuristic new;
			                add: CoGlobalVariablesHeuristic new;
			                build).
	benchmark := (CooStaticBenchmarksVariables new
		name: 'Flat global variable';
		scope: (CoBenchmarkPackage on: package);
		builder: builder;
		run).
	benchmark inspect.
	^ benchmark

]

{ #category : 'accessing' }
CooBenchRunner >> others: aSymbolCollect [

	others := aSymbolCollect 
]

{ #category : 'accessing' }
CooBenchRunner >> package: aPackage [

	package := aPackage
]

{ #category : 'accessing' }
CooBenchRunner >> run [ 

	results := Dictionary new.
	{baseline} , others
		do: [ :s | results at: s  put: (self perform: s)]

]
