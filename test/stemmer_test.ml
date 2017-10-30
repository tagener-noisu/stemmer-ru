open Jest;;
open Stemmer;;

let _ = describe "from_perfective_gerund" (fun _ ->
	let result = from_perfective_gerund (ToReplace {j|взявшись|j}) in
	let _ = it "should correctly remove endings"
		(fun _ -> expect result toEqual (Done {j|взя|j})) in

	let result = from_perfective_gerund (ToReplace {j|взевшись|j}) in
	let _ = it "should not remove endings if match fails"
		(fun _ -> expect result toEqual (ToReplace {j|взевшись|j})) in
())

let _ = describe "rv" (fun _ ->
	let _ = it "should split word after first vowel"
		(fun _ -> expect (rv {j|ололо|j}) toEqual ({j|о|j}, {j|лоло|j})) in

	let _ = it "should not split if there are no vowels"
		(fun _ -> expect (rv {j|вжжж|j}) toEqual ({j|вжжж|j}, "")) in
())

let _ = describe "from_adjectival" (fun _ ->
	let result = from_adjectival (ToReplace {j|бегавшая|j}) in
	let _ = it "should correctly remove endings"
		(fun _ -> expect result toEqual (Done {j|бега|j})) in

	let result = from_adjectival (ToReplace {j|бегаая|j}) in
	let _ = it "should correctly remove endings"
		(fun _ -> expect result toEqual (Done {j|бега|j})) in
())