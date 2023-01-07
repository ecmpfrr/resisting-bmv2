#include <core.p4>
#include <v1model.p4>
#include "common/headers.p4"

/* PARSER */
#include "bmv2_6p_frr_v2_resisting_parser_recirculation.p4"

/* INGRESS PROCESSING */
#include "bmv2_6p_frr_v2_resisting_ingress_recirculation.p4"

/* EGRESS PROCESSING */
#include "bmv2_6p_frr_v2_resisting_egress_recirculation.p4"

/* DEPARSER */
#include "bmv2_6p_frr_v2_resisting_deparser_recirculation.p4"


/* CHECKSUM VERIFICATION */
control MyVerifyChecksum(inout headers hdr,
 inout metadata meta) {


  apply { } 
}


/* CHECKSUM UPDATE */
control MyComputeChecksum(inout headers hdr,
 inout metadata meta) {


 apply {


  update_checksum(
  hdr.ipv4.isValid(),
  {hdr.ipv4.version,
   hdr.ipv4.ihl,
   hdr.ipv4.diffserv,
   hdr.ipv4.total_len,
   hdr.ipv4.identification,
   hdr.ipv4.flags,
   hdr.ipv4.frag_offset,
   hdr.ipv4.ttl,
   hdr.ipv4.protocol,
   hdr.ipv4.src_addr,
   hdr.ipv4.dst_addr},
   hdr.ipv4.hdr_checksum,
   HashAlgorithm.csum16);
   


 } 



}



/* SWITCH */
V1Switch(
 MyParser(),
 MyVerifyChecksum(),
 MyIngress(),
 MyEgress(),
 MyComputeChecksum(),
 MyDeparser()
) main;
