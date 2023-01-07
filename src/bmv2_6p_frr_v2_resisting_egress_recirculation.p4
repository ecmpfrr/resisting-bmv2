/* EGRESS PROCESSING */

  control MyEgress(
       inout headers hdr,
       inout metadata eg_md,
       inout standard_metadata_t eg_intr_md) {


register<bit<9>>(3) rg_frr_port_out_5_wr;

   action set_add_copy_port_out_add_255(bit<32> idx){
        hdr.frr.setValid();
        hdr.frr.idx_5_or_cp_5_4 = 255;
        rg_frr_port_out_5_wr.write(idx,255);
    }


   action set_add_copy_port_out_5_to_4(bit<32> idx){
        hdr.frr.setValid();
        bit<9> cp_port;
        rg_frr_port_out_5_wr.read(cp_port,idx);
        hdr.frr.idx_5_or_cp_5_4 = cp_port;
        rg_frr_port_out_5_wr.write(idx,255);
    }

  table frr_port_out_5 {
        key = {
            hdr.frr.loop : exact;
            hdr.frr.idx_port_down : exact;
            hdr.frr.dst_id : exact;
        }

        actions = {
            set_add_copy_port_out_5_to_4();
            set_add_copy_port_out_add_255();
        }

        size = 64;
    }

register<bit<9>>(3) rg_frr_port_out_4_wr;

   action set_add_copy_port_out_4_to_3(bit<32> idx){
        hdr.frr.setValid();
        bit<9> cp_port;
        rg_frr_port_out_4_wr.read(cp_port,idx);
        hdr.frr.idx_4_or_cp_4_3 = cp_port;
        rg_frr_port_out_4_wr.write(idx,hdr.frr.idx_5_or_cp_5_4);
    }

  table frr_port_out_4 {
        key = {
            hdr.frr.loop : exact;
            hdr.frr.idx_port_down : exact;
            hdr.frr.dst_id : exact;
        }

        actions = {
            set_add_copy_port_out_4_to_3();
        }

        size = 64;
    }

register<bit<9>>(3) rg_frr_port_out_3_wr;

   action set_add_copy_port_out_3_to_2(bit<32> idx){
        hdr.frr.setValid();
        bit<9> cp_port;
        rg_frr_port_out_3_wr.read(cp_port,idx);
        hdr.frr.idx_3_or_cp_3_2 = cp_port;
        rg_frr_port_out_3_wr.write(idx,hdr.frr.idx_4_or_cp_4_3);
    }

  table frr_port_out_3 {
        key = {
            hdr.frr.loop : exact;
            hdr.frr.idx_port_down : exact;
            hdr.frr.dst_id : exact;
        }

        actions = {
            set_add_copy_port_out_3_to_2();
        }

        size = 64;
    }

register<bit<9>>(3) rg_frr_port_out_2_wr;

   action set_add_copy_port_out_2_to_1(bit<32> idx){
        hdr.frr.setValid();
        bit<9> cp_port;
        rg_frr_port_out_2_wr.read(cp_port,idx);
        hdr.frr.idx_2_or_cp_2_1 = cp_port;
        rg_frr_port_out_2_wr.write(idx,hdr.frr.idx_3_or_cp_3_2);
    }

   action set_add_copy_port_out_2_to_1_and_255(bit<32> idx){
        hdr.frr.setValid();
        hdr.frr.idx_2_or_cp_2_1 = 255;
        rg_frr_port_out_2_wr.write(idx,255);
    }

     action set_add_copy_port_out_2_to_1_range(bit<32> idx){
        hdr.frr.setValid();
        bit<9> cp_port;
        rg_frr_port_out_2_wr.read(cp_port,idx);
        hdr.frr.idx_2_or_cp_2_1 = cp_port;
        rg_frr_port_out_2_wr.write(idx,255);
    }


  table frr_port_out_2 {
        key = {
            hdr.frr.loop : exact;
            hdr.frr.idx_port_down : exact;
            hdr.frr.dst_id : exact;
        }

        actions = {
            set_add_copy_port_out_2_to_1();
            set_add_copy_port_out_2_to_1_and_255();
            set_add_copy_port_out_2_to_1_range();
        }

        size = 64;
    }

register<bit<9>>(3) rg_frr_port_out_1_wr;

   action set_add_copy_port_out_1_to_0(bit<32> idx){
        hdr.frr.setValid();
        bit<9> cp_port;
        rg_frr_port_out_1_wr.read(cp_port,idx);
        hdr.frr.idx_1_or_cp_1_0 = cp_port;
        rg_frr_port_out_1_wr.write(idx,hdr.frr.idx_2_or_cp_2_1);
    }

  table frr_port_out_1 {
        key = {
            hdr.frr.loop : exact;
            hdr.frr.idx_port_down : exact;
            hdr.frr.dst_id : exact;
        }

        actions = {
            set_add_copy_port_out_1_to_0();
        }

        size = 64;
    }

register<bit<9>>(3) rg_frr_port_out_0_wr;

   action set_add_port_out_1_to_0(bit<32> idx){
        hdr.frr.setValid();
        hdr.frr.idx_0 = hdr.frr.idx_1_or_cp_1_0;
        rg_frr_port_out_0_wr.write(idx,hdr.frr.idx_1_or_cp_1_0);
    }

  table frr_port_out_0 {
        key = {
            hdr.frr.loop : exact;
            hdr.frr.idx_port_down : exact;
            hdr.frr.dst_id : exact;
        }

        actions = {
            set_add_port_out_1_to_0();
        }

        size = 64;
    }


register<bit<24>>(3) rg_count_port_up_wr;

  
  action set_count_port_up(bit<32> idx){
                 eg_md.port_count_idx = idx;
                 rg_count_port_up_wr.read(eg_md.port_count,eg_md.port_count_idx);                 
   }
  

  table count_port_up {
        key = {
            hdr.frr.update_bit : exact;
            hdr.frr.first_failure : exact;
            hdr.frr.idx_port_down : range;
            hdr.frr.dst_id : exact;
        }

        actions = {
            set_count_port_up();
        }

        size = 64;
    }



  apply {




                count_port_up.apply();  

                if(hdr.frr.update_bit == 1 && hdr.frr.first_failure == 1 && eg_md.port_count > 0){
                  hdr.frr.setValid();
                  hdr.frr.loop = 4w1;

                  frr_port_out_5.apply();
                  frr_port_out_4.apply();
                  frr_port_out_3.apply();
                  frr_port_out_2.apply();
                  frr_port_out_1.apply();
                  frr_port_out_0.apply();

                  hdr.frr.setValid();

                  rg_count_port_up_wr.write(eg_md.port_count_idx,eg_md.port_count - 1);
             }


 }



}

