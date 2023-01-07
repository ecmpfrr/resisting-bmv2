


parser MyParser(
      packet_in pkt,
      out headers hdr,
      inout metadata ig_md,
      inout standard_metadata_t ig_intr_md) {



      state start { 
           
           transition parse_ethernet; 

      }


      state parse_ethernet {
          pkt.extract(hdr.ethernet);      
          ig_md.dst_id = (bit<16>)hdr.ethernet.dst_addr;
          transition select (hdr.ethernet.ether_type) {
               0x800 : parse_ipv4;
               TYPE_FRR: parse_frr;
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

