



 control MyDeparser(
        packet_out pkt,
        in headers hdr) {
 apply {

  


          pkt.emit(hdr.ethernet);
          pkt.emit(hdr.frr);
          pkt.emit(hdr.ipv4);
          pkt.emit(hdr.tcp);








 }
}


