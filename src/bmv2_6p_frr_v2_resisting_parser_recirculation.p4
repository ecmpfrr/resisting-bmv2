


parser MyParser(
      packet_in pkt,
      out headers hdr,
      inout metadata ig_md,
      inout standard_metadata_t ig_intr_md) {
/*
     state start {
//        pkt.extract(hdr.frr);
      
      transition select(ig_intr_md.ingress_port) {
        //transition select(ig_intr_md.recirculate_port) {   
//        transition select (ig_intr_md.egress_spec) {

         10 : parse_frr;
         7  : parse_ethernet;
         default:  accept;       
       }
    }

*/


      state start { 
           
           transition parse_ethernet; 

      }


      state parse_ethernet {
          pkt.extract(hdr.ethernet);
          //pkt.extract(hdr.frr);
          ig_md.dst_id = (bit<16>)hdr.ethernet.dst_addr;
          transition select (hdr.ethernet.ether_type) {
               0x800 : parse_ipv4;
                    TYPE_FRR: parse_frr;
 //                  1 : parse_frr; 
//                     0x86dd: parser_ipv6;
               default : accept;
           }
       }


       state parse_frr {
          pkt.extract(hdr.frr);
          hdr.ethernet.ether_type = hdr.frr.ether_type_eth;
          transition select (hdr.frr.update_bit) {
                0: parse_ipv4;
                default : accept;
          }
       }


       state parse_ipv4 {
          pkt.extract(hdr.ipv4);
          //hdr.ethernet.ether_type = 0x800;
          transition select (hdr.ipv4.protocol) {
              0x006 : parse_tcp;

              default : accept;
          }
       }

        state parse_tcp {
           pkt.extract(hdr.tcp);
           transition accept;
       //   default : accept;
        }




}

