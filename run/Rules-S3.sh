
#################
#INGRES##########
################

#ipv4_lpm.add_with_set_nhop_local(0x800,'25','10.0.0.11',32,'001b:21a0:52d4','136')

table_add ipv4_lpm set_nhop_local 0x800 1 30.0.0.13/25 => 00:00:00:00:00:03 7
table_add ipv4_lpm set_nhop_local 0x800 2 30.0.0.13/25 => 00:00:00:00:00:03 7
table_add ipv4_lpm set_nhop_local 0x800 3 30.0.0.13/25 => 00:00:00:00:00:03 7
table_add ipv4_lpm set_nhop_local 0x800 4 30.0.0.13/25 => 00:00:00:00:00:03 7
table_add ipv4_lpm set_nhop_local 0x800 5 30.0.0.13/25 => 00:00:00:00:00:03 7
table_add ipv4_lpm set_nhop_local 0x800 6 30.0.0.13/25 => 00:00:00:00:00:03 7

#ipv4_lpm.add_with_set_nhop_network(0x800,'136','20.0.0.12',32,'20')

table_add ipv4_lpm set_nhop_network 0x800 7 10.0.0.0/8 =>  10
table_add ipv4_lpm set_nhop_network 0x800 7 20.0.0.0/8 =>  20

table_add ipv4_lpm set_nhop_network 0x800 0 10.0.0.0/8 =>  10
table_add ipv4_lpm set_nhop_network 0x800 0 20.0.0.0/8 =>  20


#ipv4_lpm.add_with_drop_act(0x800,'128','0.0.0.0',0)

table_add ipv4_lpm drop_act 0x800 1 0.0.0.0/0 =>

 
#rg_port_out_5.add(0,182)
register_write rg_port_out_5_wr 0 6
register_write rg_port_out_4_wr 0 5
register_write rg_port_out_3_wr 0 4
register_write rg_port_out_2_wr 0 3
register_write rg_port_out_1_wr 0 2
register_write rg_port_out_0_wr 0 1

register_write rg_default_path_wr 0 1

#update_port_out_5.add_with_set_add_port_out_5(5,1)
#S1
table_add update_port_out_5 set_add_port_out_5_loop_bit_1 5 1 10 => 0
table_add update_port_out_5 set_add_port_out_5_loop_bit_1 4 1 10 => 0
table_add update_port_out_5 set_add_port_out_5_loop_bit_1 3 1 10 => 0
table_add update_port_out_5 set_add_port_out_5_loop_bit_1 2 1 10 => 0
table_add update_port_out_5 set_add_port_out_5_loop_bit_1 1 1 10 => 0
table_add update_port_out_5 set_add_port_out_5_loop_bit_1 0 1 10 => 0

table_add update_port_out_4 set_add_port_out_4_loop_bit_1 4 1 10 => 0
table_add update_port_out_4 set_add_port_out_4_loop_bit_1 3 1 10 => 0
table_add update_port_out_4 set_add_port_out_4_loop_bit_1 2 1 10 => 0
table_add update_port_out_4 set_add_port_out_4_loop_bit_1 1 1 10 => 0
table_add update_port_out_4 set_add_port_out_4_loop_bit_1 0 1 10 => 0

table_add update_port_out_3 set_add_port_out_3_loop_bit_1 3 1 10 => 0
table_add update_port_out_3 set_add_port_out_3_loop_bit_1 2 1 10 => 0
table_add update_port_out_3 set_add_port_out_3_loop_bit_1 1 1 10 => 0
table_add update_port_out_3 set_add_port_out_3_loop_bit_1 0 1 10 => 0

table_add update_port_out_2 set_add_port_out_2_loop_bit_1 2 1 10 => 0
table_add update_port_out_2 set_add_port_out_2_loop_bit_1 1 1 10 => 0
table_add update_port_out_2 set_add_port_out_2_loop_bit_1 0 1 10 => 0

table_add update_port_out_1 set_add_port_out_1_loop_bit_1 1 1 10 => 0
table_add update_port_out_1 set_add_port_out_1_loop_bit_1 0 1 10 => 0

table_add update_port_out_0 set_add_port_out_0_loop_bit_1 0 1 10 => 0

table_add update_default_path set_add_default_path_loop_bit_1 0 1 10 => 0

#S2
table_add update_port_out_5 set_add_port_out_5_loop_bit_1 5 1 20 => 0
table_add update_port_out_5 set_add_port_out_5_loop_bit_1 4 1 20 => 0
table_add update_port_out_5 set_add_port_out_5_loop_bit_1 3 1 20 => 0
table_add update_port_out_5 set_add_port_out_5_loop_bit_1 2 1 20 => 0
table_add update_port_out_5 set_add_port_out_5_loop_bit_1 1 1 20 => 0
table_add update_port_out_5 set_add_port_out_5_loop_bit_1 0 1 20 => 0

table_add update_port_out_4 set_add_port_out_4_loop_bit_1 4 1 20 => 0
table_add update_port_out_4 set_add_port_out_4_loop_bit_1 3 1 20 => 0
table_add update_port_out_4 set_add_port_out_4_loop_bit_1 2 1 20 => 0
table_add update_port_out_4 set_add_port_out_4_loop_bit_1 1 1 20 => 0
table_add update_port_out_4 set_add_port_out_4_loop_bit_1 0 1 20 => 0

table_add update_port_out_3 set_add_port_out_3_loop_bit_1 3 1 20 => 0
table_add update_port_out_3 set_add_port_out_3_loop_bit_1 2 1 20 => 0
table_add update_port_out_3 set_add_port_out_3_loop_bit_1 1 1 20 => 0
table_add update_port_out_3 set_add_port_out_3_loop_bit_1 0 1 20 => 0

table_add update_port_out_2 set_add_port_out_2_loop_bit_1 2 1 20 => 0
table_add update_port_out_2 set_add_port_out_2_loop_bit_1 1 1 20 => 0
table_add update_port_out_2 set_add_port_out_2_loop_bit_1 0 1 20 => 0

table_add update_port_out_1 set_add_port_out_1_loop_bit_1 1 1 20 => 0
table_add update_port_out_1 set_add_port_out_1_loop_bit_1 0 1 20 => 0

table_add update_port_out_0 set_add_port_out_0_loop_bit_1 0 1 20 => 0

table_add update_default_path set_add_default_path_loop_bit_1 0 1 20 => 0

table_add fowarding_tag_5 set_fowarding_port_out_5_loop_bit_0 20 5 0 => 0
table_add fowarding_tag_4 set_fowarding_port_out_4_loop_bit_0 20 4 0 => 0
table_add fowarding_tag_3 set_fowarding_port_out_3_loop_bit_0 20 3 0 => 0
table_add fowarding_tag_2 set_fowarding_port_out_2_loop_bit_0 20 2 0 => 0
table_add fowarding_tag_1 set_fowarding_port_out_1_loop_bit_0 20 1 0 => 0
table_add fowarding_tag_0 set_fowarding_port_out_0_loop_bit_0 20 0 0 => 0
!
table_add fowarding_tag_5 set_fowarding_port_out_5_loop_bit_0 10 5 0 => 0
table_add fowarding_tag_4 set_fowarding_port_out_4_loop_bit_0 10 4 0 => 0
table_add fowarding_tag_3 set_fowarding_port_out_3_loop_bit_0 10 3 0 => 0
table_add fowarding_tag_2 set_fowarding_port_out_2_loop_bit_0 10 2 0 => 0
table_add fowarding_tag_1 set_fowarding_port_out_1_loop_bit_0 10 1 0 => 0
table_add fowarding_tag_0 set_fowarding_port_out_0_loop_bit_0 10 0 0 => 0


#table_add default_path set_default_path_loop_bit_0 255 0 => 0
table_add default_path set_default_path_loop_bit_0 255 0->5 0 10 => 0 0
table_add default_path set_default_path_loop_bit_0 255 0->5 0 20 => 0 0


table_add port_status set_port_status_down 1 0 0x800 => 0
table_add port_status set_port_status_down 2 0 0x800 => 0
table_add port_status set_port_status_down 3 0 0x800 => 0
table_add port_status set_port_status_down 4 0 0x800 => 0
table_add port_status set_port_status_down 5 0 0x800 => 0
table_add port_status set_port_status_down 6 0 0x800 => 0

table_add port_status set_port_status_down 7 0 0x800 => 0
table_add port_status set_port_status_down 8 0 0x800 => 0

table_add port_status set_port_status_down 0 0 0x255 => 0
table_add port_status set_port_status_down 0 1 0x255 => 0

table_set_default port_status drop_act

#table_add frr_recirculation set_frr_recirculation_first_failure_loop_bit_0 1 0 =>
#table_add frr_recirculation set_frr_recirculation_first_failure_loop_bit_1 0 1 =>
#table_add frr_recirculation set_frr_recirculation_first_failure_loop_bit_0 1 0 0->5 => 0 0 
#table_add frr_recirculation set_frr_recirculation_first_failure_loop_bit_1 0 1 0->5 => 0 0
table_add frr_recirculation set_frr_recirculation_first_failure_loop_bit_0 1 0 0->5 0->0 10 0 => 0 0
table_add frr_recirculation set_frr_recirculation_first_failure_loop_bit_1 0 1 0->0 0->5 10 10 => 0 0
!
table_add frr_recirculation set_frr_recirculation_first_failure_loop_bit_0 1 0 0->5 0->0 20 0 => 0 0
table_add frr_recirculation set_frr_recirculation_first_failure_loop_bit_1 0 1 0->0 0->5 20 20 => 0 0
!


#table_add frr_no_recovery set_frr_no_recovery_loop_bit_0 0 0 =>

!
!act_prof_create_group hash_path_selector
!act_prof_create_member hash_path_selector set_ecmp_path_selector 0
!act_prof_create_member hash_path_selector set_ecmp_path_selector 1
!act_prof_create_member hash_path_selector set_ecmp_path_selector 2
!act_prof_create_member hash_path_selector set_ecmp_path_selector 3
!act_prof_create_member hash_path_selector set_ecmp_path_selector 4
!act_prof_create_member hash_path_selector set_ecmp_path_selector 5
!
!act_prof_add_member_to_group hash_path_selector 0 0
!act_prof_add_member_to_group hash_path_selector 1 0
!act_prof_add_member_to_group hash_path_selector 2 0
!act_prof_add_member_to_group hash_path_selector 3 0
!act_prof_add_member_to_group hash_path_selector 4 0
!act_prof_add_member_to_group hash_path_selector 5 0
!
!table_indirect_add_with_group ecmp_hash_selector 20 0x800 => 0
!table_indirect_add_with_group ecmp_hash_selector 10 0x800 => 0

table_add update_ecmp_hash set_add_ecmp_hash_loop_bit_1 0->5 1 10 1 => 0 0
table_add update_ecmp_hash set_add_ecmp_hash_loop_bit_1 0->5 1 20 1 => 0 0

table_add ecmp_hash set_ecmp_hash 20 0x800 => 0
table_add ecmp_hash set_ecmp_hash 30 0x800 => 0

register_write rg_base_link_wr 0 0
register_write rg_max_link_wr 0 6
!
register_write rg_frr_port_out_5_wr 0 6
register_write rg_frr_port_out_4_wr 0 5
register_write rg_frr_port_out_3_wr 0 4
register_write rg_frr_port_out_2_wr 0 3
register_write rg_frr_port_out_1_wr 0 2
register_write rg_frr_port_out_0_wr 0 1
!
table_add frr_port_out_5 set_add_copy_port_out_add_255 1 5 10 => 0
table_add frr_port_out_5 set_add_copy_port_out_5_to_4 1 4 10 => 0
table_add frr_port_out_5 set_add_copy_port_out_5_to_4 1 3 10 => 0
table_add frr_port_out_5 set_add_copy_port_out_5_to_4 1 2 10 => 0
table_add frr_port_out_5 set_add_copy_port_out_5_to_4 1 1 10 => 0
table_add frr_port_out_5 set_add_copy_port_out_5_to_4 1 0 10 => 0

table_add frr_port_out_4 set_add_copy_port_out_4_to_3 1 4 10 => 0
table_add frr_port_out_4 set_add_copy_port_out_4_to_3 1 3 10 => 0
table_add frr_port_out_4 set_add_copy_port_out_4_to_3 1 2 10 => 0
table_add frr_port_out_4 set_add_copy_port_out_4_to_3 1 1 10 => 0
table_add frr_port_out_4 set_add_copy_port_out_4_to_3 1 0 10 => 0

table_add frr_port_out_3 set_add_copy_port_out_3_to_2 1 3 10 => 0
table_add frr_port_out_3 set_add_copy_port_out_3_to_2 1 2 10 => 0
table_add frr_port_out_3 set_add_copy_port_out_3_to_2 1 1 10 => 0
table_add frr_port_out_3 set_add_copy_port_out_3_to_2 1 0 10 => 0

table_add frr_port_out_2 set_add_copy_port_out_2_to_1 1 2 10 => 0
table_add frr_port_out_2 set_add_copy_port_out_2_to_1 1 1 10 => 0
table_add frr_port_out_2 set_add_copy_port_out_2_to_1 1 0 10 => 0

table_add frr_port_out_1 set_add_copy_port_out_1_to_0 1 1 10 => 0
table_add frr_port_out_1 set_add_copy_port_out_1_to_0 1 0 10 => 0

table_add frr_port_out_0 set_add_port_out_1_to_0 1 0 10 => 0

table_add frr_port_out_5 set_add_copy_port_out_add_255 1 5 20 => 0
table_add frr_port_out_5 set_add_copy_port_out_5_to_4 1 4 20 => 0
table_add frr_port_out_5 set_add_copy_port_out_5_to_4 1 3 20 => 0
table_add frr_port_out_5 set_add_copy_port_out_5_to_4 1 2 20 => 0
table_add frr_port_out_5 set_add_copy_port_out_5_to_4 1 1 20 => 0
table_add frr_port_out_5 set_add_copy_port_out_5_to_4 1 0 20 => 0

table_add frr_port_out_4 set_add_copy_port_out_4_to_3 1 4 20 => 0
table_add frr_port_out_4 set_add_copy_port_out_4_to_3 1 3 20 => 0
table_add frr_port_out_4 set_add_copy_port_out_4_to_3 1 2 20 => 0
table_add frr_port_out_4 set_add_copy_port_out_4_to_3 1 1 20 => 0
table_add frr_port_out_4 set_add_copy_port_out_4_to_3 1 0 20 => 0

table_add frr_port_out_3 set_add_copy_port_out_3_to_2 1 3 20 => 0
table_add frr_port_out_3 set_add_copy_port_out_3_to_2 1 2 20 => 0
table_add frr_port_out_3 set_add_copy_port_out_3_to_2 1 1 20 => 0
table_add frr_port_out_3 set_add_copy_port_out_3_to_2 1 0 20 => 0

table_add frr_port_out_2 set_add_copy_port_out_2_to_1 1 2 20 => 0
table_add frr_port_out_2 set_add_copy_port_out_2_to_1 1 1 20 => 0
table_add frr_port_out_2 set_add_copy_port_out_2_to_1 1 0 20 => 0

table_add frr_port_out_1 set_add_copy_port_out_1_to_0 1 1 20 => 0
table_add frr_port_out_1 set_add_copy_port_out_1_to_0 1 0 20 => 0

table_add frr_port_out_0 set_add_port_out_1_to_0 1 0 20 => 0

register_write rg_count_port_up_wr 0 5

table_add count_port_up set_count_port_up 1 1 0->5 10 => 0 0
table_add count_port_up set_count_port_up 1 1 0->5 20 => 0 0








