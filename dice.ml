Random.self_init ()

let udice sides =
  if sides < 0 then
    failwith "a dice can't have negative amount of sides";
  match sides with
    | 0 -> 0
    | _ -> 1 + Random.int sides;;

let rec dice amount sides =
  if amount < 0 then
    failwith "you can't throw a negative amount of dice";
  match amount with
    | 0 -> 0
    | _ -> udice sides + dice (amount - 1) sides;;

let ( <* ) lhs rhs = dice lhs rhs
let ( !* ) rhs = udice rhs
