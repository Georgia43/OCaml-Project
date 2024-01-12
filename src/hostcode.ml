open Hostmatch 
open Graph

(*graph with source, sink, nodes representing hosts, nodes representing hackers, arcs leaving from source and going to hackers and arcs leaving from hosts and going to sink*)
let our_graph la lo = (*la is the list of hackers and lo the list of hosts*)
  let source_id = 0 in
  let sink_id = 1 in

  let g = new_node empty_graph source_id in (* Source node with id 0 *)
  let g_with_p = new_node g sink_id in (* Sink node with id 1 *)

  let rec all_hacks graph l =
    match l with
    | x :: rest ->
        let new_node = new_node graph x.a_id in (*create node representing hacker*)
        let updated_graph = new_arc new_node { src = source_id; tgt = x.a_id; lbl = 1 } in (*create arc between source and hacker*)
        all_hacks updated_graph rest
    | [] -> graph
  in

  let graph_with_hacks = all_hacks g_with_p la in

  let rec all_hosts graph l =
    match l with
    | y :: rest ->
        let new_node = new_node graph y.o_id in (*create node representing host*)
        let updated_graph = new_arc new_node { src = y.o_id; tgt = sink_id; lbl = 1 } in (*create arc between host and sink*)
        all_hosts updated_graph rest
    | [] -> graph
  in

  let final_graph = all_hosts graph_with_hacks lo in (*finak graph contains all hackers and hosts*)
  final_graph
;;

(*add the arcs between hosts and hackers while respecting the allergy and cat constraint*)
let create_arcs gr la lo =
  let rec iterate_hackers g hackers =
    match hackers with
    | [] -> g
    | hacker :: rest ->
        let updated_graph =
          if not hacker.all then (*the hacker is not allergic to cats*)
            let rec connect_to_hosts graph hosts =
              match hosts with
              | [] -> graph
              | host :: remaining_hosts ->
                  let new_graph = new_arc graph {src = hacker.a_id; tgt = host.o_id; lbl = 1} in (*we create an arc between the hacker and all the hosts because he has no constraints*)
                  connect_to_hosts new_graph remaining_hosts
            in
            connect_to_hosts g lo
          else (*the hacker is allergic to cats*)
            let rec connect_to_hosts_2 graph hosts =
              match hosts with
              | [] -> graph
              | host :: remaining_hosts -> (*we have to check if the host owns a cat or not*)
                  if not host.cat then
                    let new_graph = new_arc graph {src = hacker.a_id; tgt = host.o_id; lbl = 1} in (*the host doesnt have a cat so we create an arc from the hacker to the host*)
                    connect_to_hosts_2 new_graph remaining_hosts
                  else
                    connect_to_hosts_2 graph remaining_hosts (*we dont create an arc because the host has a cat*)
            in
            connect_to_hosts_2 g lo
        in
        iterate_hackers updated_graph rest
  in

  iterate_hackers gr la





