open Graph
open Tools
open Gfile

(*find a path between a given source and destination*)
let rec find_path src dest gr visited acu = (*visited parameter to avoid going back to the same node*)
  if src=dest then acu 
  else if List.mem src visited then []
  else
   let list = out_arcs gr src in   (*list of all arcs leaving from src*)
  treat_out_arcs list dest gr (src::visited) acu 
    
        
and treat_out_arcs arcs dest gr visited acu =   
  match arcs with
      | [] -> [] (*no path*)
      |x::rest when x.lbl=0 -> treat_out_arcs rest dest gr visited acu  (*ignore the arcs that have a label 0*)
      | x::rest when find_path x.tgt dest gr visited (x::acu) = [] ->  treat_out_arcs rest dest gr visited acu  (*no path found so we check the next arc*)
      | x::_-> find_path x.tgt dest gr visited (x::acu)  (*dest found*);;

(*get all the arcs of a graph in a list*)
let get_all_arcs graph = 
  let accumulate acu arc = (arc :: acu) in
      e_fold graph accumulate [] ;;

(*change the label of the arc to a label given*)     
let change_label arc label ={src=arc.src; tgt = arc.tgt; lbl=label} ;;

(*go back to flow graph for final representation of graph*)
let flow_graph original obtained = (*obtained is the deviation graph that we obtain at the end of ford fulkerson*)
  let rec iterate list modified_original = (*to iterate on all the arcs of the original graph*)
    match list with
    | [] -> modified_original
    | x :: rest ->
        match find_arc obtained x.src x.tgt with (*find the arc in the deviation graph in order to get its label*)
        | None -> failwith "Corresponding arc not found"
       | Some y when y.lbl=0 -> iterate rest modified_original
        | Some y -> 
            (let new_original = add_arc modified_original x.src x.tgt (-y.lbl) in (*modify the label of the original graph according to the arc of the obtained graph*)
            iterate rest new_original)
          
  in
  iterate (get_all_arcs original) original ;;


(*find the minimum label given a list of arcs*)
let min_label list = 
  match list with
    |[]-> failwith "Empty list"
    |x::rest-> List.fold_left (fun acu y -> min acu y.lbl) x.lbl rest;;

(*function used for testing/verification: prints every source in a list of arcs*)
let show_path l =
  let _ = Printf.printf "[" in 
  let _ = List.iter (fun x -> Printf.printf "%d " x.src) l in
  let _ = Printf.printf "] \n %!"
in  () ;; 


(*modify the capacities of the arcs in the path*)
let modify_cap gr path min = (*modifies the shape of the arc*)
  let rec add_cap gr path min = (*to add the flow arcs*)
  match path with
  |[]-> gr
  |[a]-> add_arc gr a.tgt a.src min
  |a1 :: rest -> add_cap (add_arc gr a1.tgt a1.src min) rest min
  in 
  let rec sub_cap gr path min = (*to change the capacity*)
    match path with
    |[]-> gr
    |[a]-> add_arc gr a.src a.tgt (-min)
    |a1 :: rest -> sub_cap (add_arc gr a1.src a1.tgt (-min)) rest min
  in sub_cap (add_cap gr path min)  path min;;
  
(*finds the minimum of the path and changes tthe graph accordingly*)
let update_graph gr path = 
  let min = min_label path in 
  modify_cap gr path min;;

(*ford fulkerson algorithm*)
  let ford_fulk gr src dest =
    let rec algo flow graph = (*at the beginning, the flow is 0*)
   (* let augmenting_path acu = (*Printf.printf "test path"*)find_path src dest acu []  in *)
   let path = find_path src dest graph [] [] in
      if (path = []) then (flow,graph) (*no path was found -> end of algorithm : returns the maximum flow and the final deviation graph*)
      else
        let _ = show_path path in
        let min =  Printf.printf "test min %!" ; min_label path in 
        let max_flow = flow + min in (*update the value of the max flow*)
        let new_graph = update_graph graph path in
        let g =  gmap new_graph string_of_int in (*used only for testing*)
        let () = export "test5" g in
        algo max_flow new_graph in (*apply the recursion to the new graph until no more path found*)
        
     algo 0 gr ;; 
        