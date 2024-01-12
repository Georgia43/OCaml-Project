open Graph 


type host =
  { name: string ;
    cat: bool;
    o_id: id }

    type hacker =
    { hname: string ;
      all: bool ;
      a_id: id }




val from_file_match : string -> host list * hacker list ;;
