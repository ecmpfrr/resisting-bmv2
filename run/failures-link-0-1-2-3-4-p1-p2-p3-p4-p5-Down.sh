table_clear port_status
table_add port_status set_port_status_down 1 0 0x800 => 1
table_add port_status set_port_status_down 2 0 0x800 => 1
table_add port_status set_port_status_down 3 0 0x800 => 1
table_add port_status set_port_status_down 4 0 0x800 => 1
table_add port_status set_port_status_down 5 0 0x800 => 1
table_add port_status set_port_status_down 6 0 0x800 => 0

table_add port_status set_port_status_down 7 0 0x800 => 0
table_add port_status set_port_status_down 8 0 0x800 => 0


table_add port_status set_port_status_down 0 0 0x255 => 0
table_add port_status set_port_status_down 0 1 0x255 => 0


table_set_default port_status drop_act

