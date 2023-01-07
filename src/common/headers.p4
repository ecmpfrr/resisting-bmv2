
typedef bit<48> mac_addr_t;
typedef bit<32> ipv4_addr_t;
typedef bit<128> ipv6_addr_t;
typedef bit<12> vlan_id_t;
typedef bit<9> PortId_t;
typedef bit<16> dst_id_t;
typedef bit<32> idx_reg_t;


const bit<16> TYPE_FRR = 16w0x255;

header frr_h {
    bit<4> loop;
    bit<9> idx_port_down;
    bit<9> idx_0;
    bit<9> idx_1_or_cp_1_0;
    bit<9> idx_2_or_cp_2_1;
    bit<9> idx_3_or_cp_3_2;
    bit<9> idx_4_or_cp_4_3;
    bit<9> idx_5_or_cp_5_4;
    bit<5> update_bit;
// Ethernet Ether_type 0x255 (FRR), 0x800 (Ipv4)
    bit<16> ether_type_eth;
    bit<24> first_failure;
    bit<16> dst_id;
}


header ethernet_h {
    mac_addr_t dst_addr;
    mac_addr_t src_addr;
    bit<16> ether_type;
}
header ipv4_h {
    bit<4> version;
    bit<4> ihl;
    bit<8> diffserv;
    bit<16> total_len;
    bit<16> identification;
    bit<3> flags;
    bit<13> frag_offset;
    bit<8> ttl;
    bit<8> protocol;
    bit<16> hdr_checksum;
    bit<32> src_addr;
    bit<32> dst_addr;
}

header ipv6_h {
    bit<4> version;
    bit<8> traffic_class;
    bit<20> flow_label;
    bit<16> payload_len;
    bit<8> next_hdr;
    bit<8> hop_limit;
    ipv6_addr_t src_addr;
    ipv6_addr_t dst_addr;
}

header tcp_h {
    bit<16> src_port;
    bit<16> dst_port;
    bit<32> seq_no;
    bit<32> ack_no;
    bit<4> data_offset;
    bit<4> res;
    bit<8> flags;
    bit<16> window;
    bit<16> checksum;
    bit<16> urgent_ptr;
}

header udp_h {
    bit<16> src_port;
    bit<16> dst_port;
    bit<16> hdr_length;
    bit<16> checksum;
}

header icmp_h {
    bit<8> type_;
    bit<8> code;
    bit<16> hdr_checksum;
}




/* HEADERS */
struct metadata {
   bit<16> dst_id;
   bit<9> ecmp_path_selector;
   bit<1> port_status_up_down;
   bit<24> port_count;
   bit<32> port_count_idx;
}
struct headers {

    frr_h frr;
    ethernet_h ethernet;
    ipv4_h ipv4;
    ipv6_h ipv6;
    tcp_h tcp;
    udp_h udp;
    icmp_h icmp;
    // Add more headers here Ex: IPv6.

}


