(** Compilation from ocaml to javascript, using js_of_ocaml. This module supports both
    - compiling a single bytecode executable to javascript (using [rule])
    - compiling each cmo/cma to javascript (using [rule]), and linking them. *)
open! Import

val exe_suf : string
val cma_suf : string
val cmo_suf : string
val runtime_suf : string
val jsdeps_suf : string

val with_sourcemap_suf : string -> string

(** [rule ~dir ~flags ~src:bytecode ~target:javascript_file] creates the rule to
    compile a bytecode program (or bytecode compilation unit) to JavaScript using
    the js_of_ocaml compiler.

    [options] are given to js_of_ocaml compiler (ie: --pretty) *)
val rule
   : artifacts:Named_artifact.Store.t
  -> sourcemap : bool
  -> devel : bool
  -> build_info:Path.t option
  -> hg_version:Path.t option
  -> dir:Path.t
  -> flags:string list
  -> findlib_flags:string list Dep.t
  -> js_files:Path.t list Dep.t
  -> src:Path.t
  -> target:Path.t
  -> Rule.t

val rule_for_standalone_runtime
  :  artifacts:Named_artifact.Store.t
  -> sourcemap : bool
  -> devel : bool
  -> build_info:Path.t option
  -> hg_version:Path.t option
  -> dir:Path.t
  -> flags:string list
  -> findlib_flags:string list Dep.t
  -> js_files:Path.t list Dep.t
  -> target:Path.t
  -> Rule.t

val runtime_files_for_lib_in_compiler_distribution
  :  artifacts:Named_artifact.Store.t
  -> Ocaml_types.From_compiler_distribution.t
  -> Path.t Dep.t list

val link_js_files
  :  artifacts:Named_artifact.Store.t
  -> sourcemap : bool
  -> dir:Path.t
  -> files:Path.t list
  -> target: Path.t
  -> Action.t Dep.t

(** [from_external_archives ~ocaml_where paths] converts paths of findlib archives
    into paths of the same archives compiled to JavaScript *)
val from_external_archives : ocaml_where:Path.t -> Path.t list -> Path.t list Dep.t

(** [from_compiler_distribution lib] returns the path of the library [lib] compiled to JavaScript *)
val from_compiler_distribution : Ocaml_types.From_compiler_distribution.t -> Path.t

(** Path of the stdlib compiled to JavaScript (stdlib.cma.js) *)
val stdlib_from_compiler_distribution : Path.t

val dot_js_dir : Path.t
val setup_dot_js_dir
  :  artifacts:Named_artifact.Store.t
  -> sourcemap : bool
  -> devel : bool
  -> ocaml_where:Path.t
  -> Path.t
  -> Jenga_lib.Api.Scheme.t

val gen_html_for_inline_tests
  :  libname: Ocaml_types.Libname.t
  -> argv: string list
  -> drop_test: bool
  -> exe: string
  -> string
