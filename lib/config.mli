(** The implementation of this module is overridden in the public release

    It contains various configuration elements that are different in the opam world
*)

open Import

val putenv : tmpdir:Path.t -> (string * string option) list

val findlib_conf_default : string option

(** Directory containing the scripts required by the rules *)
val script_dir : Path.t

(** Directory containing executables required by the rules *)
val priority_path_dir : Path.t

(** Whether we are running inside Jane Street or from publicly released packages *)
val public : bool

val command_lookup_path : [ `Replace | `Extend ]

val git_prog    : string
val hg_prog     : string
val nodejs_prog : string
val emacs_prog  : string
val opam_prog   : string

val public_release_build_servers_default : string
