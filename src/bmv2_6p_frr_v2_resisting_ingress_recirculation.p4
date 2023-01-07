/* INGRESS PROCESSING */



 control MyIngress(
       inout headers hdr,
       inout metadata ig_md,
       inout standard_metadata_t ig_intr_md) {

   action drop_act() {
      mark_to_drop(ig_intr_md);
   }



   action set_nhop_local(mac_addr_t dstAddr, PortId_t port) {
        hdr.ethernet.setValid();
        hdr.ethernet.ether_type = 0x0800;
        hdr.ethernet.dst_addr = dstAddr;
        hdr.ipv4.setValid();
        hdr.ipv4.ttl = hdr.ipv4.ttl - 1;
        ig_intr_md.egress_spec = port;
        ig_md.dst_id = 0;
   }


     action set_nhop_network(dst_id_t dst_id) {
        ig_md.dst_id = dst_id;
     }


     table ipv4_lpm {
        key = {
            hdr.ethernet.ether_type: exact;
            ig_intr_md.ingress_port: exact;
            hdr.ipv4.dst_addr: lpm;
        }
        actions = {
            set_nhop_network;
            set_nhop_local;
            drop_act;
        }
        //const default_action = drop_act;
        size = 64;

     }

//Version 1
/*
 action set_ecmp_path_selector(bit<9> idx){

    ig_md.ecmp_path_selector = idx;
 }

 // Act_Sel(HashAlg.crc32, max_group_size, num_groups)

  action_selector(HashAlgorithm.crc32, 32w12, 32w256) hash_path_selector;

 table ecmp_hash_selector {
        key = {

            ig_md.dst_id: exact;
            hdr.ethernet.ether_type: exact;
            hdr.ipv4.src_addr: selector;
            hdr.ipv4.dst_addr: selector;
            hdr.ipv4.protocol: selector;
            hdr.tcp.src_port: selector;
            hdr.tcp.dst_port: selector;
            

        }
        actions = {
            drop_act;
            set_ecmp_path_selector;
          
         }
        implementation = hash_path_selector; 

    }
*/

 register<bit<16>>(3) rg_base_link_wr;
 register<bit<32>>(3) rg_max_link_wr;


 action set_add_ecmp_hash_loop_bit_1(bit<32> idx){
         bit<32> max_link;
         rg_max_link_wr.read(max_link,idx);
         rg_max_link_wr.write(idx,max_link - 1);
        }


 table update_ecmp_hash {
        key = {
            hdr.frr.idx_port_down : range;
            hdr.frr.loop : exact;
            hdr.frr.dst_id : exact;
            hdr.frr.first_failure : exact;
        }

        actions = {
            set_add_ecmp_hash_loop_bit_1;
        }

        size = 64;
    }


 action set_ecmp_hash(bit<32> idx) {
         bit<16> base_link;
         bit<32> max_link;

         rg_base_link_wr.read(base_link,idx);
         rg_max_link_wr.read(max_link,idx);
         hash(ig_md.ecmp_path_selector, HashAlgorithm.crc32,
                 base_link,     
                 {hdr.ipv4.src_addr,
                  hdr.ipv4.dst_addr,
                  hdr.ipv4.protocol,
                  hdr.tcp.src_port,
                  hdr.tcp.dst_port},
                  max_link);  
       }       


 table ecmp_hash {
        key = {
                       
            ig_md.dst_id: exact;
            hdr.ethernet.ether_type: exact;
        }
        actions = {
            drop_act;
            set_ecmp_hash;
         }
        size = 64;
    }



register<bit<9>>(3) rg_default_path_wr;

  action set_add_default_path_loop_bit_1(bit<32> idx) {
             rg_default_path_wr.write(idx,hdr.frr.idx_0);
   }

 action set_add_default_path_loop_bit_1_ecmp_idx_range_1(bit<32> idx) {
             rg_default_path_wr.write(idx,hdr.frr.idx_0);
   }

 action set_add_default_path_loop_bit_1_ecmp_idx_range_2_idx_3(bit<32> idx) {
             rg_default_path_wr.write(idx,hdr.frr.idx_4_or_cp_4_3);
   }

  action set_add_default_path_loop_bit_1_ecmp_idx_range_2_idx_0(bit<32> idx) {
             rg_default_path_wr.write(idx,hdr.frr.idx_0);
   }


  action set_add_default_path_loop_bit_1_ecmp_idx_range_3(bit<32> idx) {
             rg_default_path_wr.write(idx,hdr.frr.idx_0);
   }


 table update_default_path {
        key = {
            hdr.frr.idx_port_down : exact;
            hdr.frr.loop : exact;
            hdr.frr.dst_id : exact;
        }

        actions = {
            set_add_default_path_loop_bit_1;
            set_add_default_path_loop_bit_1_ecmp_idx_range_1;
            set_add_default_path_loop_bit_1_ecmp_idx_range_2_idx_0;
            set_add_default_path_loop_bit_1_ecmp_idx_range_2_idx_3;
            set_add_default_path_loop_bit_1_ecmp_idx_range_3;
        }

        size = 64;
    }

   action set_default_path_loop_bit_0(bit<32> idx){
         bit<9> port_out;
         rg_default_path_wr.read(port_out,idx);
         ig_intr_md.egress_spec = port_out;
         ig_md.ecmp_path_selector = 0;
    }

   action set_default_path_loop_bit_0_ecmp_idx_range_1(bit<32> idx){
         bit<9> port_out;
         rg_default_path_wr.read(port_out,idx);
         ig_intr_md.egress_spec = port_out;
         ig_md.ecmp_path_selector = 0;
  
   }

   action set_default_path_loop_bit_0_ecmp_idx_range_2(bit<32> idx){
         bit<9> port_out;
         rg_default_path_wr.read(port_out,idx);
         ig_intr_md.egress_spec = port_out;
         ig_md.ecmp_path_selector = 3;

   }

   action set_default_path_loop_bit_0_ecmp_idx_range_3(bit<32> idx){
         bit<9> port_out;
         rg_default_path_wr.read(port_out,idx);
         ig_intr_md.egress_spec = port_out;
         ig_md.ecmp_path_selector = 0;

   }


  table default_path {
        key = {
            ig_intr_md.egress_spec : exact;
            ig_md.ecmp_path_selector : range;
            hdr.frr.loop : exact;
            ig_md.dst_id : exact;
        }

        actions = {
            set_default_path_loop_bit_0;
            set_default_path_loop_bit_0_ecmp_idx_range_1;
            set_default_path_loop_bit_0_ecmp_idx_range_2;
            set_default_path_loop_bit_0_ecmp_idx_range_3;
            drop_act;
        }

        size = 64;
       // const default_action = drop_act;
    }


register<bit<9>>(3) rg_port_out_5_wr;

   action set_add_port_out_5_loop_bit_1(bit<32> idx) {
          rg_port_out_5_wr.write(idx,255);
     }

  table update_port_out_5 {
        key = {
            hdr.frr.idx_port_down : exact;
            hdr.frr.loop : exact;
            hdr.frr.dst_id : exact;
        }

        actions = {
            set_add_port_out_5_loop_bit_1;
        }

        size = 64;
     }

   action set_fowarding_port_out_5_loop_bit_0(bit<32> idx) {
         hdr.ethernet.setValid();
         hdr.ethernet.dst_addr = (bit<48>)ig_md.dst_id;
         hdr.ethernet.ether_type = 0x800;
         bit<9> port_out;
         rg_port_out_5_wr.read(port_out,idx);
         ig_intr_md.egress_spec = port_out;
      }

  table fowarding_tag_5 {
       actions = {
             set_fowarding_port_out_5_loop_bit_0();
        }
         key = {
             ig_md.dst_id : exact;
             ig_md.ecmp_path_selector : exact;
             hdr.frr.loop : exact;
          }
         size = 64;
      //   default_action = drop_act;
    }


register<bit<9>>(3) rg_port_out_4_wr;

   action set_add_port_out_4_loop_bit_1(bit<32> idx) {
          rg_port_out_4_wr.write(idx,hdr.frr.idx_5_or_cp_5_4);
     }

  table update_port_out_4 {
        key = {
            hdr.frr.idx_port_down : exact;
            hdr.frr.loop : exact;
            hdr.frr.dst_id : exact;
        }

        actions = {
            set_add_port_out_4_loop_bit_1;
        }

        size = 64;
     }

   action set_fowarding_port_out_4_loop_bit_0(bit<32> idx) {
         hdr.ethernet.setValid();
         hdr.ethernet.dst_addr = (bit<48>)ig_md.dst_id;
         hdr.ethernet.ether_type = 0x800;
         bit<9> port_out;
         rg_port_out_4_wr.read(port_out,idx);
         ig_intr_md.egress_spec = port_out;
      }

  table fowarding_tag_4 {
       actions = {
             set_fowarding_port_out_4_loop_bit_0();
        }
         key = {
             ig_md.dst_id : exact;
             ig_md.ecmp_path_selector : exact;
             hdr.frr.loop : exact;
          }
         size = 64;
      //   default_action = drop_act;
    }


register<bit<9>>(3) rg_port_out_3_wr;

   action set_add_port_out_3_loop_bit_1(bit<32> idx) {
         rg_port_out_3_wr.write(idx,hdr.frr.idx_4_or_cp_4_3);
     }

  table update_port_out_3 {
        key = {
            hdr.frr.idx_port_down : exact;
            hdr.frr.loop : exact;
            hdr.frr.dst_id : exact;
        }

        actions = {
            set_add_port_out_3_loop_bit_1;
        }

        size = 64;
     }

   action set_fowarding_port_out_3_loop_bit_0(bit<32> idx) {
         hdr.ethernet.setValid();
         hdr.ethernet.dst_addr = (bit<48>)ig_md.dst_id;
         hdr.ethernet.ether_type = 0x800;
         bit<9> port_out;
         rg_port_out_3_wr.read(port_out,idx);
         ig_intr_md.egress_spec = port_out;
      }

  table fowarding_tag_3 {
       actions = {
             set_fowarding_port_out_3_loop_bit_0();
        }
         key = {
             ig_md.dst_id : exact;
             ig_md.ecmp_path_selector : exact;
             hdr.frr.loop : exact;
          }
         size = 64;
      //   default_action = drop_act;
    }



register<bit<9>>(3) rg_port_out_2_wr;

   action set_add_port_out_2_loop_bit_1(bit<32> idx) {
         rg_port_out_2_wr.write(idx,hdr.frr.idx_3_or_cp_3_2); 
    }

    action set_add_port_out_2_loop_bit_1_add_255(bit<32> idx) {
         rg_port_out_2_wr.write(idx,255);
    }


  table update_port_out_2 {
        key = {
            hdr.frr.idx_port_down : exact;
            hdr.frr.loop : exact;
            hdr.frr.dst_id : exact;
        }

        actions = {
            set_add_port_out_2_loop_bit_1;
            set_add_port_out_2_loop_bit_1_add_255;
        }

        size = 64;
     }

   action set_fowarding_port_out_2_loop_bit_0(bit<32> idx) {
         hdr.ethernet.setValid();
         hdr.ethernet.dst_addr = (bit<48>)ig_md.dst_id;
         hdr.ethernet.ether_type = 0x800;
         bit<9> port_out;
         rg_port_out_2_wr.read(port_out,idx);
         ig_intr_md.egress_spec = port_out;
      }

  table fowarding_tag_2 {
       actions = {
             set_fowarding_port_out_2_loop_bit_0();
        }
         key = {
             ig_md.dst_id : exact;
             ig_md.ecmp_path_selector : exact;
             hdr.frr.loop : exact;
          }
         size = 64;
      //   default_action = drop_act;
    }


register<bit<9>>(3) rg_port_out_1_wr;

   action set_add_port_out_1_loop_bit_1(bit<32> idx) {
         rg_port_out_1_wr.write(idx,hdr.frr.idx_2_or_cp_2_1);
     }

  table update_port_out_1 {
        key = {
            hdr.frr.idx_port_down : exact;
            hdr.frr.loop : exact;
            hdr.frr.dst_id : exact;
        }

        actions = {
            set_add_port_out_1_loop_bit_1;
        }

        size = 64;
     }

   action set_fowarding_port_out_1_loop_bit_0(bit<32> idx) {
         hdr.ethernet.setValid();
         hdr.ethernet.dst_addr = (bit<48>)ig_md.dst_id;
         hdr.ethernet.ether_type = 0x800;
         bit<9> port_out;
         rg_port_out_1_wr.read(port_out,idx);
         ig_intr_md.egress_spec = port_out;
      }

  table fowarding_tag_1 {
       actions = {
             set_fowarding_port_out_1_loop_bit_0();
        }
         key = {
             ig_md.dst_id : exact;
             ig_md.ecmp_path_selector : exact;
             hdr.frr.loop : exact;
          }
         size = 64;
      //   default_action = drop_act;
    }


register<bit<9>>(3) rg_port_out_0_wr;

   action set_add_port_out_0_loop_bit_1(bit<32> idx) {
         rg_port_out_0_wr.write(idx,hdr.frr.idx_0);
     }

  table update_port_out_0 {
        key = {
            hdr.frr.idx_port_down : exact;
            hdr.frr.loop : exact;
            hdr.frr.dst_id : exact;
         }

        actions = {
            set_add_port_out_0_loop_bit_1;
        }

        size = 64;
     }

   action set_fowarding_port_out_0_loop_bit_0(bit<32> idx) {
          hdr.ethernet.setValid();
          hdr.ethernet.dst_addr = (bit<48>)ig_md.dst_id;
          hdr.ethernet.ether_type = 0x800;
          bit<9> port_out;
          rg_port_out_0_wr.read(port_out,idx);
          ig_intr_md.egress_spec = port_out;
      }

  table fowarding_tag_0 {
       actions = {
             set_fowarding_port_out_0_loop_bit_0();
        }
         key = {
             ig_md.dst_id : exact;
             ig_md.ecmp_path_selector : exact;
             hdr.frr.loop : exact;
          }
         size = 64;
      //   default_action = drop_act;
    }

   action set_port_status_down(bit<16> bit_down){
         ig_md.port_status_up_down = (bit<1>)bit_down;
    }

  table port_status {
        key = {
            ig_intr_md.egress_spec : exact;
            hdr.frr.loop : exact;
            hdr.ethernet.ether_type: exact;
    }

        actions = {
            set_port_status_down;
            drop_act;
        }

        size = 64;
        const default_action = drop_act;
    }






register<bit<24>>(3) dr_rg_first_failure_count_wr;

   action set_frr_recirculation_first_failure_loop_bit_0(bit<32> idx){
         hdr.ethernet.setValid();
         hdr.ethernet.ether_type = 0x255;
         hdr.frr.setValid();
// adiciona a posicao do index/posicao que armazena a porta down de saida
         hdr.frr.idx_port_down =  ig_md.ecmp_path_selector;
         hdr.frr.update_bit = 1;
         hdr.frr.ether_type_eth = 0x255;
         bit<24> count;
         dr_rg_first_failure_count_wr.read(count,idx);
         dr_rg_first_failure_count_wr.write(idx,count + 1); 
         hdr.frr.first_failure = count + 1;
         hdr.frr.dst_id = ig_md.dst_id;
         recirculate<headers>(hdr);
 }

   action set_frr_recirculation_first_failure_loop_bit_1(bit<32> idx){
         dr_rg_first_failure_count_wr.write(idx,0);
         hdr.ethernet.setValid();
         hdr.ethernet.ether_type = 0x800;
         hdr.frr.setInvalid();
         hdr.frr.update_bit = 0; 
         hdr.frr.first_failure = 0;
         recirculate<headers>(hdr);
  }

   table frr_recirculation {
        key = {
            ig_md.port_status_up_down : exact;
            hdr.frr.loop : exact; 
            ig_md.ecmp_path_selector : range;
            hdr.frr.idx_port_down : range;
            ig_md.dst_id : exact;
            hdr.frr.dst_id : exact;

    }

        actions = {
            set_frr_recirculation_first_failure_loop_bit_1;
            set_frr_recirculation_first_failure_loop_bit_0;
           // drop_act;
        }

        size = 6;
       // const default_action = drop_act;

    }

    action set_frr_no_recovery_loop_bit_0(){
         hdr.frr.setInvalid();
         hdr.ethernet.setValid();
         hdr.ethernet.ether_type = 0x800;
   }

   table frr_no_recovery {
        key = {
            ig_md.port_status_up_down : exact;
            hdr.frr.loop : exact;

    }

        actions = {
            set_frr_no_recovery_loop_bit_0;
       }

        size = 64;

    }






  apply {


        ipv4_lpm.apply();
//        ecmp_hash_selector.apply();
        update_ecmp_hash.apply();
        ecmp_hash.apply();
        update_port_out_5.apply();
        update_port_out_4.apply();
        update_port_out_3.apply();
        update_port_out_2.apply();
        update_port_out_1.apply();
        update_port_out_0.apply();
 //       update_default_path.apply();

        fowarding_tag_5.apply();
        fowarding_tag_4.apply();
        fowarding_tag_3.apply();
        fowarding_tag_2.apply();
        fowarding_tag_1.apply();
        fowarding_tag_0.apply();
//        default_path.apply();
      
        port_status.apply();

      @atomic{
        frr_recirculation.apply();
        }



   }



}

