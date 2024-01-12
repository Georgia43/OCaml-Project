
open Graph 
open Hostmatch


val our_graph : hacker list -> host list -> id graph ;;
val create_arcs : id graph -> hacker list -> host list -> id graph ;;