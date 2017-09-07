external reg_match : string -> Js.Re.t -> string array option
  = "match"[@@bs.send][@@bs.return nullable]
    
external replace : string -> Js.Re.t -> string -> string = ""[@@bs.send]

external regExp : string -> string -> Js.Re.t = "RegExp"[@@bs.new]

let vowel = {j|[аеёиоуыэюя]|j}
let consonant = {j|[^аеёиоуыэюя]|j}

let from_perfective_gerund word =
  let group_one = [%bs.re "/([ая])в(?:шись|ши)?$/i"] in
    let group_two = [%bs.re "/[иы]в(?:шись|ши)?$/i"] in
      word
      |. replace group_one "$1"
        |. replace group_two ""
  
  
let from_adjective word =
  word |. replace
  [%bs.re "/(?:[еиыо][ейм]у?)|(?:[уеою]ю|[ая]я|[ыи]х|[ео]го)$/i"]
""

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