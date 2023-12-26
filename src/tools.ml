open Graph

let clone_nodes _gr = n_fold _gr new_node empty_graph ;;  

let gmap _gr _f = e_fold _gr (fun acu a -> new_arc acu {src=a.src; tgt=a.tgt;lbl=(_f (a.lbl))}) (clone_nodes _gr) ;; 

let add_arc _gr id1 id2 n = 
  let a = (find_arc _gr id1 id2) in 
    match a with
      |None -> new_arc _gr {src= id1 ; tgt=id2 ; lbl=n}
      |Some x -> new_arc _gr {src= x.src ; tgt=x.tgt ; lbl=(x.lbl+n)}
;;



  


