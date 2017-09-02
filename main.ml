open Tsdl
open Gg
open Result
open Tgl3


let rect surface =
  let rect = Some Sdl.Rect.(create 10 10 100 100) in
  match Sdl.fill_rect surface rect 1000l with
  | Error (`Msg e) -> Log.(msg Error "Failed to draw rect: %s" e)
  | Ok _ -> ()


let main window =
  match Sdl.gl_create_context window with
  | Error (`Msg e) -> Log.(msg Critical "Failed to create OpenGL context: %s" e); exit 1
  | Ok _ ->

  Gl.clear_color 0.9 0.1 0.3 1.0;
  Gl.clear Gl.color_buffer_bit;

  Sdl.gl_swap_window window;
  (* let surface = match Sdl.get_window_surface window with
  | Error (`Msg e) -> Log.(msg Critical "Failed to get window surface: %s" e); exit 1
  | Ok surface' -> surface' in

  rect surface;

  match Sdl.update_window_surface window with
  | Error (`Msg e) -> Log.(msg Error "Failed to update window surface: %s" e)
  | Ok _ -> (); *)

  Sdl.delay 5000l;

  Sdl.destroy_window window;
  Sdl.quit ();
  exit 0


let set_opengl_min_version major minor =
  match Sdl.gl_set_attribute Sdl.Gl.context_major_version major with
  | Error (`Msg e) -> Log.(msg Critical "Failed to set opengl min major version: %s" e); exit 1
  | Ok () ->
  match Sdl.gl_set_attribute Sdl.Gl.context_minor_version minor with
  | Error (`Msg e) -> Log.(msg Critical "Failed to set opengl min minor version: %s" e); exit 1
  | Ok () -> ()


let () =
  Log.(msg Info "Starting...");

  match Sdl.init Sdl.Init.(video + audio) with
  | Error (`Msg e) -> Log.(msg Critical "Init error: %s" e); exit 1
  | Ok () ->

  set_opengl_min_version 3 2;

  (* vsync *)
  ignore (Sdl.gl_set_swap_interval 1);

  match Sdl.create_window ~w:640 ~h:480 "Apnea" Sdl.Window.(windowed + shown + opengl) with
  | Error (`Msg e) -> Log.(msg Critical "Create window error: %s" e); exit 1
  | Ok window -> main window
