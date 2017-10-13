external reg_match : string -> Js.Re.t -> string array option
  = "match"[@@bs.send][@@bs.return nullable] 
external replace : string -> Js.Re.t -> string -> string = ""[@@bs.send]
external regExp : string -> string -> Js.Re.t = "RegExp"[@@bs.new]

type replace_result = | Replace of string | Done of string [@@bs.deriving ]

(* chainable replace function, replaces only once in a chain *)
let replace word regex replace_val =
  match word with
    | Done word -> Done word
    | Replace word ->
      let result = word |. replace regex replace_val in
        if result == word then Replace word
        else Done result

let vowel = {j|[аеёиоуыэюя]|j}
let consonant = {j|[^аеёиоуыэюя]|j}

let from_perfective_gerund word =
  let group_one = [%bs.re "/([ая])(?:вшись|вши|в)$/i"] in
  let group_two = [%bs.re "/[иы](?:вшись|вши|в)$/i"] in
  Replace word
  |. replace group_one "$1"
  |. replace group_two ""
  
let from_adjective word =
  word |. replace
  [%bs.re "/(?:[еиыо][ейм]у?)|(?:[уеою]ю|[ая]я|[ыи]х|[ео]го)$/i"]
  ""

let from_reflexive word =
  word |. replace [%bs.re "/с[яь]$/i"] ""

let from_participle word =
  let group_one = [%bs.re "/([ая])(?:ем|нн|вш|ющ)$/i"] in
  let group_two = [%bs.re "/(?:щ|ивш|ывш|ющ)$/i"] in
  word
  |. replace group_one "$1"
  |. replace group_two ""
  
let from_verb word =
  let group_one = [%bs.re "/([ая])(?:е(?:м|т|шь)|[йн]|ли?|[ей]те|[лн]о|ют|ны|ть|нно|[дн]а)$/i"] in
  let group_two = [%bs.re "/(?:[ыи]л[аио]?|[иы]м|ен[ао]?|[еу]й(?:те)?|[ияы]т|[иы]ть|ите|ены|у[ею]т|у?ю|ишь)$/i"] in
  word
  |. replace group_one "$1"
  |. replace group_two ""
  
let from_noun word =
  word |. replace [%bs.re "/(?:[ео]в|[иь]е|(?:а|и?я)ми?|[ие]и|(?:а|и?я)х|[иь][юя]|и?ем|о[мй]|[еи]?й|[аеоюыьуя])$/i"] ""

let from_superlative word =
  word |. replace [%bs.re "/ейше?$/i"] ""

let from_derivational word =
  word |. replace [%bs.re "/ость?$/i"] ""

let rv word =
  let regex = regExp {j|$consonant*$vowel(.+)\$|j} "i" in
    match word |. reg_match regex with
    | Some([|_;result |]) -> result
    | _ -> ""

let r1 word =
  let regex = regExp {j|$vowel$consonant(.+)\$|j} "i" in
    match word |. reg_match regex with
    | Some([|_;result |]) -> result
    | _ -> ""

let r2 word = r1(r1 word)