external reg_match : string -> Js.Re.t -> string array option
  = "match"[@@bs.send][@@bs.return nullable]

external regExp : string -> string -> Js.Re.t = "RegExp"[@@bs.new]

let vowel = {j|[аеёиоуыэюя]|j}
let consonant = {j|[^аеёиоуыэюя]|j}

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
