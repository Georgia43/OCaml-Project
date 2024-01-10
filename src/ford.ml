open Graph
open Tools
open Gfile


let rec find_path src dest gr visited acu = 
  if src=dest then acu 
  else if List.mem src visited then []
  else

   let list = out_arcs gr src in
  treat_out_arcs list dest gr (src::visited) acu 
    
        
and treat_out_arcs arcs dest gr visited acu =   
  match arcs with
      | [] -> [] (*no path*)
      |x::rest when x.lbl=0 -> treat_out_arcs rest dest gr visited acu   
      | x::rest when find_path x.tgt dest gr visited (x::acu) = [] ->  treat_out_arcs rest dest gr visited acu   
      | x::_-> find_path x.tgt dest gr visited (x::acu)  (*dest found*);;
      


let min_label list = 
  match list with
    |[]-> failwith "Empty list"
    |x::rest-> List.fold_left (fun acu y -> min acu y.lbl) x.lbl rest;;

let show_path l =
  let _ = Printf.printf "[" in 
  let _ = List.iter (fun x -> Printf.printf "%d " x.src) l in
  let _ = Printf.printf "] \n %!"
in  () ;; 


  
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
  

let update_graph gr path = (*finds the minimum of the path and changes tthe graph accordingly*)
  let min = min_label path in 
  modify_cap gr path min;;


(*let rec ford_fulk gr src dest=
  let rec loop max_flow graph= 
    (*on renvoie le flow max
       --> si find path vide on renvoie maxflow
  else???*)
    let augmenting_path = find_path graph src dest [] in 
    if augmenting_path = [] then
      max_flow (*no more paths, return the max flow*) 
    else begin
        (*modifier capacites des arcs du find path et min label sur find path pour modifier max flow*)
        let flow_to_add = min_label augmenting_path in
        let updated_graph = modify_cap graph augmenting_path flow_to_add (*function that modifies capacities*)
        loop (max_flow+flow_to_add) updated_graph
    end
  in
  loop 0 gr(*initial flow = 0*)*)



  let ford_fulk gr src dest =
    let rec algo flow graph = (*at the beginning, the flow is 0*)
   (* let augmenting_path acu = (*Printf.printf "test path"*)find_path src dest acu []  in *)
   let path = find_path src dest graph [] []  in
      if (path = []) then (flow,graph)
      else
        let _ = show_path path in
        let min =  Printf.printf "test min %!" ; min_label path in 
        let max_flow = flow + min in
        let new_graph = update_graph graph path in
        let g =  gmap new_graph string_of_int in
        let () = export "test5" g in
        algo max_flow new_graph in
        
     algo 0 gr ;; 
        