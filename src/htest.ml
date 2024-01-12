
open Hostcode
open Ford
(*open Graph*)
open Tools
open Gfile
open Hostmatch

let () =
  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 3 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("      infile  : input file containing a list of hackers and a list of hosts that is turned into a graph\n" ^
         "      source  : identifier of the source vertex\n" ^
         "      sink    : identifier of the sink vertex (ditto)\n" ^
         "      outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;

    

  (* Arguments are: infile(1) source-id(2) sink-id(3) outfile(4) *)
  let infile = Sys.argv.(1)
  and outfile2 = Sys.argv.(2)
  (*and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)*)
  in

  (* Open file and create the graph *)
  let hosts, hackers = from_file_match infile in
  let initial_graph = our_graph hackers hosts in
  let graph = create_arcs initial_graph hackers hosts in

  (* Run Ford-Fulkerson algorithm *)
  let ford_result = ford_fulk graph 0 1 in
  let max_flow = fst ford_result in
  let final_graph = snd ford_result in

  (* Print the max flow and export the final graph *)
  let () = Printf.printf "Max Flow: %d\n" max_flow in 

  (*let g4 = gmap final_graph string_of_int in*)
  let g5 = flow_graph graph final_graph in
let g6 = gmap g5 string_of_int in
  let () = export outfile2 g6 in
  ()
