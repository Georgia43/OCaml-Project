open Gfile
open Tools  
open Ford
(*open Graph*)

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4) 
  
  (* These command-line arguments are not used for the moment. *)
  and source = int_of_string Sys.argv.(2)
  and sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in 

   let g2 = gmap graph int_of_string in 
  (*let g3 = add_arc g2 3 4 1000000 in
  let g4 = gmap g3 string_of_int in*)

  (* Rewrite the graph that has been read. 
  let () = write_file outfile g4 in

  ()
 let () = export outfile graph in

  ()*)
(*
 let graph = from_file infile in *)
(*let _ = Printf.printf "[" in 
  let _ = List.iter (fun x -> Printf.printf "%d ----- %d \n " x.src x.tgt) (get_all_arcs g2) in
  let _ = Printf.printf "]" in *)
let ford = ford_fulk g2 source sink in 
let flow =  (fst ford) in  
let final_graph = (snd ford) in 
let _ = Printf.printf "max flow : %d" flow in 
let g4 = gmap final_graph string_of_int in
(*let g5 = flow_graph g2 final_graph in
let g6 = gmap g5 string_of_int in*)
 let () = export outfile g4 in

  ()
  (*let g1 = List.iter (fun x -> Printf.printf "%d" x.tgt) in*)
  (*let _ = Printf.printf "[" in 
  let _ = List.iter (fun x -> Printf.printf "%d \n" x.src) g2 in
  let _ = Printf.printf "]" in 
  let _ = Printf.printf "min label %d\n" (min_label g2) in 
  ()*)

(*let _ = Printf.printf "%d\n" g2 in *)
(*let g3 = gmap g2 string_of_int in
(* Rewrite the graph that has been read. *)
  let () = write_file outfile g3 in
()*)
(*let g3 = update_graph graph g2 in*)

 (*let g3 = modify_cap g2 (find_path 0 5 graph []) 5 in  
 let g4 = gmap g3 string_of_int in
 let () = export outfile g4 in

  ()*)