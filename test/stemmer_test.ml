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
