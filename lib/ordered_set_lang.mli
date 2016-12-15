
(* [Ordered_set_lang.t] is a sexp-based representation for an ordered list of strings,
   with some set like operations. *)

open Core.Std

type t [@@deriving of_sexp]
val eval_with_standard : t option -> standard:string list -> string list
val standard : t

module Unexpanded : sig
  type expanded = t
  type t [@@deriving of_sexp]

  (** List of files needed to expand this set *)
  val files : t -> String.Set.t

  (** Expand [t] using with the given file contents. [file_contents] is a map from
      filenames to their parsed contents. Every [(< fn)] in [t] is replaced by [Map.find
      files_contents fn]. *)
  val expand : t -> files_contents:Sexp.t String.Map.t -> expanded
end with type expanded := t
