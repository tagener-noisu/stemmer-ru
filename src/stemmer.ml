open Regexp;;

type replace_result = | ToReplace of string | Done of string [@@bs.deriving accessors]

(* chainable replace function, replaces only once in a chain *)
let replace word regex replace_val =
  match word with
    | Done word -> Done word
    | ToReplace word ->
      let result = String.replace word regex replace_val in
        if result == word then ToReplace word
        else Done result

let vowel = {j|[аеёиоуыэюя]|j}
let consonant = {j|[^аеёиоуыэюя]|j}

let from_perfective_gerund word =
  let group_one = [%bs.re "/([ая])(?:вшись|вши|в)$/i"] in
  let group_two = [%bs.re "/[иы](?:вшись|вши|в)$/i"] in
  word
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

let from_adjectival word =
  match word |> from_adjective with
  | ToReplace word -> ToReplace word
  | Done word ->
    match ToReplace word |> from_participle with
    | ToReplace word -> Done word
    | Done word -> Done word

let rv word =
  let regex = regExp {j|($consonant*$vowel)(.+)\$|j} "i" in
    match String.reg_match word regex with
    | Some([|_; hd; tl|]) -> (hd, tl)
    | _ -> (word, "")

let r1 word =
  let regex = regExp {j|$vowel$consonant(.+)\$|j} "i" in
    match String.reg_match word regex with
    | Some([|_;result |]) -> result
    | _ -> ""

let r2 word = r1(r1 word)