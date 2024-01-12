open Graph 

type host =
  { name: string ;
    cat: bool;
    o_id: id }

    type hacker =
    { hname: string ;
      all: bool ;
      a_id: id }



let append_item lst a = lst @ [a] ;;


let read_host list line =
  try
    Scanf.sscanf line "o %s %s %d"
      (fun n cond i ->
        let cat = match cond with (*if the host has a cat or not*)
          | "cat" -> true
          | "not" -> false
          | _ -> failwith "Invalid condition"
        in
        append_item list { name = n; cat; o_id = i }
      )
  with e ->
    Printf.printf "Cannot read host in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"
;;



    let read_hacker list line =
      try
        Scanf.sscanf line "a %s %s %d"
          (fun n cond i ->
            let all = match cond with (*if the hacker is allergic or not*)
              | "all" -> true
              | "not" -> false
              | _ -> failwith "Invalid condition"
            in
            append_item list { hname = n; all; a_id = i }
          )
      with e ->
        Printf.printf "Cannot read hacker in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
        failwith "from_file"
    ;;
    

(* Reads a comment or fail. *)
let read_comment list line =
  try Scanf.sscanf line " %%" list
  with _ ->
    Printf.printf "Unknown line:\n%s\n%!" line ;
    failwith "from_file"
  ;;

  
  let from_file_match path =
    let infile = open_in path in
  
    let rec loop (hosts, hackers) =
      try
        let line = input_line infile in
  
        (* Remove leading and trailing spaces. *)
        let line = String.trim line in
  
        let (new_hosts, new_hackers) =
          (* Ignore empty lines *)
          if line = "" then (hosts, hackers)
  
          (* The first character of a line determines its content: o or a. *)
          else match line.[0] with
            | 'o' -> (read_host hosts line, hackers)
            | 'a' -> (hosts, read_hacker hackers line)
  
            (* It should be a comment, otherwise we complain. *)
            | _ -> read_comment (hosts, hackers) line
        in
        loop (new_hosts, new_hackers)
  
      with End_of_file -> (hosts, hackers) (* Done *)
    in
  
    let (final_hosts, final_hackers) = loop ([], []) in
    close_in infile;
  (final_hosts, final_hackers)
  

