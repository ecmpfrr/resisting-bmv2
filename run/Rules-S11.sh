
#################
#INGRES##########
################

#S3
register_write rg_port_out_2_wr 2 9
register_write rg_port_out_1_wr 2 8
register_write rg_port_out_0_wr 2 7
#S2
register_write rg_port_out_2_wr 1 6
register_write rg_port_out_1_wr 1 5
register_write rg_port_out_0_wr 1 4
#S1
register_write rg_port_out_2_wr 0 3
register_write rg_port_out_1_wr 0 2
register_write rg_port_out_0_wr 0 1

#S1,S2,S3
register_write rg_default_path_wr 0 1
register_write rg_default_path_wr 1 4
register_write rg_default_path_wr 2 7



table_add update_port_out_2 set_add_port_out_2_loop_bit_1_add_255 2 1 20 => 1
table_add update_port_out_2 set_add_port_out_2_loop_bit_1_add_255 1 1 20 => 1
table_add update_port_out_2 set_add_port_out_2_loop_bit_1_add_255 0 1 20 => 1

table_add update_port_out_1 set_add_port_out_1_loop_bit_1 1 1 20 => 1
table_add update_port_out_1 set_add_port_out_1_loop_bit_1 0 1 20 => 1

table_add update_port_out_0 set_add_port_out_0_loop_bit_1 0 1 20 => 1

table_add update_port_out_2 set_add_port_out_2_loop_bit_1_add_255 2 1 10 => 0
table_add update_port_out_2 set_add_port_out_2_loop_bit_1_add_255 1 1 10 => 0
table_add update_port_out_2 set_add_port_out_2_loop_bit_1_add_255 0 1 10 => 0

table_add update_port_out_1 set_add_port_out_1_loop_bit_1 1 1 10 => 0
table_add update_port_out_1 set_add_port_out_1_loop_bit_1 0 1 10 => 0

table_add update_port_out_0 set_add_port_out_0_loop_bit_1 0 1 10 => 0

#S3
table_add update_port_out_2 set_add_port_out_2_loop_bit_1_add_255 2 1 30 => 2
table_add update_port_out_2 set_add_port_out_2_loop_bit_1_add_255 1 1 30 => 2
table_add update_port_out_2 set_add_port_out_2_loop_bit_1_add_255 0 1 30 => 2

table_add update_port_out_1 set_add_port_out_1_loop_bit_1 1 1 30 => 2
table_add update_port_out_1 set_add_port_out_1_loop_bit_1 0 1 30 => 2

table_add update_port_out_0 set_add_port_out_0_loop_bit_1 0 1 30 => 2
!!!



table_add update_default_path set_add_default_path_loop_bit_1_ecmp_idx_range_1 0 1 10 => 0
table_add update_default_path set_add_default_path_loop_bit_1_ecmp_idx_range_2_idx_0 3 1 20 => 1
#S3
table_add update_default_path set_add_default_path_loop_bit_1_ecmp_idx_range_3 0 1 30 => 2
!!!


table_add fowarding_tag_2 set_fowarding_port_out_2_loop_bit_0 20 2 0 => 1
table_add fowarding_tag_1 set_fowarding_port_out_1_loop_bit_0 20 1 0 => 1
table_add fowarding_tag_0 set_fowarding_port_out_0_loop_bit_0 20 0 0 => 1
table_add default_path set_default_path_loop_bit_0_ecmp_idx_range_1 255 0->2 0 20 => 1 1

table_add fowarding_tag_2 set_fowarding_port_out_2_loop_bit_0 10 2 0 => 0
table_add fowarding_tag_1 set_fowarding_port_out_1_loop_bit_0 10 1 0 => 0
table_add fowarding_tag_0 set_fowarding_port_out_0_loop_bit_0 10 0 0 => 0

table_add default_path set_default_path_loop_bit_0_ecmp_idx_range_1 255 0->2 0 10 => 0 0

#S3
table_add fowarding_tag_2 set_fowarding_port_out_2_loop_bit_0 30 2 0 => 2
table_add fowarding_tag_1 set_fowarding_port_out_1_loop_bit_0 30 1 0 => 2
table_add fowarding_tag_0 set_fowarding_port_out_0_loop_bit_0 30 0 0 => 2

table_add default_path set_default_path_loop_bit_0_ecmp_idx_range_1 255 0->2 0 30 => 2 2




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


table_add frr_recirculation set_frr_recirculation_first_failure_loop_bit_0 1 0 0->2 0->0 10 0 => 0 0
table_add frr_recirculation set_frr_recirculation_first_failure_loop_bit_1 0 1 0->0 0->2 10 10 => 0 0
!
table_add frr_recirculation set_frr_recirculation_first_failure_loop_bit_0 1 0 0->2 0->0 20 0 => 1 1
table_add frr_recirculation set_frr_recirculation_first_failure_loop_bit_1 0 1 0->0 0->2 20 20 => 1 1

#S3
table_add frr_recirculation set_frr_recirculation_first_failure_loop_bit_0 1 0 0->2 0->0 30 0 => 2 2
table_add frr_recirculation set_frr_recirculation_first_failure_loop_bit_1 0 1 0->0 0->2 30 30 => 2 2



!V1
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
!act_prof_add_member_to_group hash_path_selector 3 1
!act_prof_add_member_to_group hash_path_selector 4 1
!act_prof_add_member_to_group hash_path_selector 5 1
!
!table_indirect_add_with_group ecmp_hash_selector 10 0x800 => 0
!table_indirect_add_with_group ecmp_hash_selector 20 0x800 => 1
!table_indirect_add_with_group ecmp_hash_selector 30 0x800 => 2

table_add update_ecmp_hash set_add_ecmp_hash_loop_bit_1 0->2 1 10 1 => 0 0
table_add update_ecmp_hash set_add_ecmp_hash_loop_bit_1 0->2 1 20 1 => 1 1
table_add update_ecmp_hash set_add_ecmp_hash_loop_bit_1 0->2 1 30 1 => 2 2

table_add ecmp_hash set_ecmp_hash 10 0x800 => 0
table_add ecmp_hash set_ecmp_hash 20 0x800 => 1
table_add ecmp_hash set_ecmp_hash 30 0x800 => 2


!
register_write rg_base_link_wr 0 0
register_write rg_max_link_wr 0 3
register_write rg_base_link_wr 1 0
register_write rg_max_link_wr 1 3
register_write rg_base_link_wr 2 0
register_write rg_max_link_wr 2 3


!
register_write rg_frr_port_out_2_wr 2 9
register_write rg_frr_port_out_1_wr 2 8
register_write rg_frr_port_out_0_wr 2 7
register_write rg_frr_port_out_2_wr 1 6
register_write rg_frr_port_out_1_wr 1 5
register_write rg_frr_port_out_0_wr 1 4
register_write rg_frr_port_out_2_wr 0 3
register_write rg_frr_port_out_1_wr 0 2
register_write rg_frr_port_out_0_wr 0 1
!

table_add frr_port_out_2 set_add_copy_port_out_2_to_1_and_255 1 2 20 => 1
table_add frr_port_out_2 set_add_copy_port_out_2_to_1_range 1 1 20 => 1
table_add frr_port_out_2 set_add_copy_port_out_2_to_1_range 1 0 20 => 1

table_add frr_port_out_1 set_add_copy_port_out_1_to_0 1 1 20 => 1
table_add frr_port_out_1 set_add_copy_port_out_1_to_0 1 0 20 => 1

table_add frr_port_out_0 set_add_port_out_1_to_0 1 0 20 => 1

table_add frr_port_out_2 set_add_copy_port_out_2_to_1_and_255 1 2 10 => 0
table_add frr_port_out_2 set_add_copy_port_out_2_to_1_range 1 1 10 => 0
table_add frr_port_out_2 set_add_copy_port_out_2_to_1_range 1 0 10 => 0


table_add frr_port_out_1 set_add_copy_port_out_1_to_0 1 1 10 => 0
table_add frr_port_out_1 set_add_copy_port_out_1_to_0 1 0 10 => 0

table_add frr_port_out_0 set_add_port_out_1_to_0 1 0 10 => 0

#S3
table_add frr_port_out_2 set_add_copy_port_out_2_to_1_and_255 1 2 30 => 2
table_add frr_port_out_2 set_add_copy_port_out_2_to_1_range 1 1 30 => 2
table_add frr_port_out_2 set_add_copy_port_out_2_to_1_range 1 0 30 => 2
table_add frr_port_out_1 set_add_copy_port_out_1_to_0 1 1 30 => 2
table_add frr_port_out_1 set_add_copy_port_out_1_to_0 1 0 30 => 2
table_add frr_port_out_0 set_add_port_out_1_to_0 1 0 30 => 2


register_write rg_count_port_up_wr 0 2

register_write rg_count_port_up_wr 1 2

table_add count_port_up set_count_port_up 1 1 0->2 10 => 0 0
table_add count_port_up set_count_port_up 1 1 0->2 20 => 1 1

#S3
register_write rg_count_port_up_wr 2 2
table_add count_port_up set_count_port_up 1 1 0->2 30 => 2 2









