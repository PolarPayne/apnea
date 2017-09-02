open Tsdl


type level =
  | Verbose
  | Debug
  | Info
  | Warn
  | Error
  | Critical


let priority_of_log_level level =
  Sdl.Log.(match level with
  | Verbose -> priority_verbose
  | Debug -> priority_debug
  | Info -> priority_info
  | Warn -> priority_warn
  | Error -> priority_error
  | Critical -> priority_critical)


let msg level msg =
  let level' = priority_of_log_level level in
  Sdl.log_message Sdl.Log.category_application level' msg
