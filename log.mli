type level =
  | Verbose
  | Debug
  | Info
  | Warn
  | Error
  | Critical

val msg : level -> ('b, Format.formatter, unit) format -> 'b
