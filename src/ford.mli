open Graph



val find_path : id -> id -> int graph -> int list -> int arc list-> int arc list;;

val min_label : int arc list -> int;;

val modify_cap : id graph -> int arc list -> id -> id graph;;

val update_graph : id graph -> id arc list -> id graph;;

val ford_fulk : id graph -> id -> id  ->  id*id graph;;

val get_all_arcs : id graph -> int arc list ;;

val change_label : int arc -> int -> int arc ;;

val flow_graph : int graph -> int graph -> int graph ;;
 