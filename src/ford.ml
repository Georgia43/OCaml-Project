open Graph


let rec find_path src dest gr acu = 
  if src=dest then acu else
   let list = out_arcs gr src in
  treat_out_arcs list dest gr acu 
    
        
and treat_out_arcs arcs dest gr acu =   
  match arcs with
      | [] -> [] (*no path*)
      | x::rest when find_path x.tgt dest gr (x::acu) = [] ->  treat_out_arcs rest dest gr acu   
      | x::_-> find_path x.tgt dest gr (x::acu)  (*dest found*);;
      


let min_label list = 
  match list with
    |[]-> failwith "Empty list"
    |x::rest-> List.fold_left (fun acu y -> min acu y.lbl) x.lbl rest;;

let rec ford_fulk gr src dest=
  let rec loop max_flow = 
    (*on renvoie le flow max
       --> si find path vide on renvoie maxflow
  else???*)
    let augmenting_path = find_path gr src dest [] in 
    if augmenting_path = [] then
      max_flow (*no more paths, return the max flow*) 
    else begin
        (*modifier capacites et min label sur find path pour modifier max flow*)
        let flow_to_add = min_label augmenting_path in
        loop (max_flow+flow_to_add)
    end
  in
  loop 0 (*initial flow = 0*)