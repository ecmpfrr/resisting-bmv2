#!/usr/bin/env python2

# Copyright 2013-present Barefoot Networks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

from mininet.net import Mininet
from mininet.topo import Topo
from mininet.log import setLogLevel, info
from mininet.cli import CLI
from mininet.link import TCLink
from p4_mininet import P4Switch, P4Host

import argparse
from time import sleep
import tempfile
import os

parser = argparse.ArgumentParser(description='Mininet demo')
parser.add_argument('--behavioral-exe', help='Path to behavioral executable',
                    type=str, action="store", required=True)
parser.add_argument('--thrift-port', help='Thrift server port for table updates',
                    type=int, action="store", default=9090)
parser.add_argument('--num-hosts', help='Number of hosts to connect to switch',
                    type=int, action="store", default=2)
parser.add_argument('--mode', choices=['l2', 'l3'], type=str, default='l3')
parser.add_argument('--json', help='Path to JSON config file',
                    type=str, action="store", required=True)
parser.add_argument('--pcap-dump', help='Dump packets on interfaces to pcap files',
                    type=str, action="store", required=False, default=False)
parser.add_argument('--log-file', help='Enable logging to given file',
                    type=str, action="store", dest="log_dir", default='/tmp/log')

parser.add_argument('--log-console', help='Enable logging to given file')


args = parser.parse_args()


class SingleSwitchTopo(Topo):
    "Single switch connected to n (< 256) hosts."
    def __init__(self, sw_path, json_path, thrift_port, pcap_dump, n, **opts):
        # Initialize topology and default options
        Topo.__init__(self, **opts)

        switch1 = self.addSwitch('s1',
                                sw_path = sw_path,
                                json_path = json_path,
                                thrift_port =9090,
                          #      log-file = sw-log,
                                pcap_dump = pcap_dump,
                               
                                mac = '00:33:00:00:01:')


        switch2 = self.addSwitch('s2',
                                sw_path = sw_path,
                                json_path = json_path,
                                thrift_port = 9091,
                                pcap_dump = pcap_dump,
                                mac = '00:33:00:00:02:')


        switch3 = self.addSwitch('s3',
                                sw_path = sw_path,
                                json_path = json_path,
                                thrift_port = 9092,
                                pcap_dump = pcap_dump,
                                mac = '00:33:00:00:00:03')

        switch11 = self.addSwitch('s11',
                                sw_path = sw_path,
                                json_path = json_path,
                                thrift_port = 9093,
                                pcap_dump = pcap_dump,
                                mac = '00:33:00:00:00:04')

        switch12 = self.addSwitch('s12',
                                sw_path = sw_path,
                                json_path = json_path,
                                thrift_port = 9095,
                                pcap_dump = pcap_dump,
                                mac = '00:33:00:00:00:05')     


       # switch13 = self.addSwitch('sw13',
       #                         sw_path = sw_path,
       #                         json_path = json_path,
       #                         thrift_port = 9095,
       #                         pcap_dump = pcap_dump,
       #                         mac = '00:33:00:00:00:06')


      # logfile = "/tmp/p4s.{}.log".format()

        self.addLink(switch1, switch11, mtu='1550')
        self.addLink(switch1, switch11, mtu='1550')
        self.addLink(switch1, switch11, mtu='1550')
        self.addLink(switch1, switch12, mtu='1550') 
        self.addLink(switch1, switch12, mtu='1550') 
        self.addLink(switch1, switch12, mtu='1550') 

        self.addLink(switch2, switch11)
        self.addLink(switch2, switch11)
        self.addLink(switch2, switch11)
        self.addLink(switch2, switch12)
        self.addLink(switch2, switch12)
        self.addLink(switch2, switch12)  

        self.addLink(switch3, switch11)
        self.addLink(switch3, switch11)
        self.addLink(switch3, switch11)
        self.addLink(switch3, switch12)
        self.addLink(switch3, switch12)
        self.addLink(switch3, switch12)  

        #self.addLink(loop, switch1)
        #self.addLink(loop, switch1)

     #   self.addLink(switch, switch3, delay='1000ms')



    #    for h in xrange(n):
        host1 = self.addHost('h1',
                                ip = "10.0.0.11/24", defaultRoute='via 10.0.0.1',
                                mac = '00:00:00:00:00:01')                         

        self.addLink(host1, switch1)
               
        host2 = self.addHost('h2',
                                ip = "20.0.0.12/24", defaultRoute='via 20.0.0.1',
                                mac = '00:00:00:00:00:02')

          
        self.addLink(host2, switch2)
 
        host3 = self.addHost('h3',
                                ip = "30.0.0.13/24", defaultRoute='via 30.0.0.1',
                                mac = '00:00:00:00:00:03')

        self.addLink(host3, switch3)         
       
        host4 = self.addHost('h4',
                                ip = "40.0.0.10/24", defaultRoute='via 40.0.0.1',
                                mac = '00:00:00:00:00:04')

        self.addLink(host4, switch1)

       # self.addLink(switch13, switch1)
       # self.addLink(switch13, switch1)



      #  bridge = self.addHost('br1')

      #  self.addLink(bridge, switch1)
      #  self.addLink(bridge, switch1)



#Loop CABLE
#        self.addLink(switch1, mtu='1550')
#        self.addLink(switch1, switch1, mtu='1550')



def main():
    num_hosts = args.num_hosts
    mode = args.mode

    topo = SingleSwitchTopo(args.behavioral_exe,
                            args.json,
                            args.thrift_port, 
                          #  args.log-file,
                            args.pcap_dump,
                           # args.file, 
                            num_hosts)
    net = Mininet(topo = topo,
                  link=TCLink,
                  host = P4Host,
                  switch = P4Switch,
                  controller = None)
    net.start()


    sw_mac = ["00:03:bb:00:00:%01x" % n for n in xrange(num_hosts + 1)]

    sw_addr = ["10.0.%d.1" % n for n in xrange(num_hosts + 1)]

    for n in xrange(num_hosts + 1):
        h = net.get('h%d' % (n + 1))
        if mode == "l2":
            h.setDefaultRoute("dev eth0")
        else:
            h.setARP(sw_addr[n], sw_mac[n])
            h.setDefaultRoute("dev eth0 via %s" % sw_addr[n])

    for n in xrange(num_hosts + 1):
        h = net.get('h%d' % (n + 1))
        h.describe()


   
    h1 = net.get( 'h1' )
    h1.cmd( 'ifconfig h1-eth0:1 10.0.0.11/24')
    h1.cmd( 'ifconfig h1-eth0:2 10.0.0.12/24')
    h1.cmd( 'ifconfig h1-eth0:3 10.0.0.13/24')
    h1.cmd( 'ifconfig h1-eth0:4 10.0.0.14/24')
    h1.cmd( 'ifconfig h1-eth0:5 10.0.0.15/24')
    h1.cmd( 'ifconfig h1-eth0:6 10.0.0.16/24')
    h1.cmd( 'ifconfig h1-eth0:7 10.0.0.17/24')
    h1.cmd( 'ifconfig h1-eth0:8 10.0.0.18/24')
    h1.cmd( 'ifconfig h1-eth0:9 10.0.0.19/24')
    h1.cmd( 'ifconfig h1-eth0:10 10.0.0.20/24')


    h1.setDefaultRoute("dev h1-eth0 via 10.0.0.1")
    h1.cmd('arp -i h1-eth0 -s 10.0.0.1 00:33:00:00:00:01') 

   
    h2 = net.get( 'h2' )
    h2.cmd( 'ifconfig h2-eth0:1 20.0.0.11/24')
    h2.cmd( 'ifconfig h2-eth0:2 20.0.0.12/24')
    h2.cmd( 'ifconfig h2-eth0:3 20.0.0.13/24')
    h2.cmd( 'ifconfig h2-eth0:4 20.0.0.14/24')
    h2.cmd( 'ifconfig h2-eth0:5 20.0.0.15/24')
    h2.cmd( 'ifconfig h2-eth0:6 20.0.0.16/24')
    h2.cmd( 'ifconfig h2-eth0:7 20.0.0.17/24')
    h2.cmd( 'ifconfig h2-eth0:8 20.0.0.18/24')
    h2.cmd( 'ifconfig h2-eth0:9 20.0.0.19/24')
    h2.cmd( 'ifconfig h2-eth0:10 20.0.0.20/24')


    h2.setDefaultRoute("dev h2-eth0 via 20.0.0.1")
    h2.cmd('arp -i h2-eth0 -s 20.0.0.1 00:33:00:00:00:02')


    h3 = net.get( 'h3' )
    h3.cmd( 'ifconfig h3-eth0:1 30.0.0.11/24')
    h3.cmd( 'ifconfig h3-eth0:2 30.0.0.12/24')
    h3.cmd( 'ifconfig h3-eth0:3 30.0.0.13/24')
    h3.cmd( 'ifconfig h3-eth0:4 30.0.0.14/24')
    h3.cmd( 'ifconfig h3-eth0:5 30.0.0.15/24')
    h3.cmd( 'ifconfig h3-eth0:6 30.0.0.16/24')
    h3.cmd( 'ifconfig h3-eth0:7 30.0.0.17/24')
    h3.cmd( 'ifconfig h3-eth0:8 30.0.0.18/24')
    h3.cmd( 'ifconfig h3-eth0:9 30.0.0.19/24')
    h3.cmd( 'ifconfig h3-eth0:10 30.0.0.20/24')


    h3.setDefaultRoute("dev h3-eth0 via 30.0.0.1")
    h3.cmd('arp -i h3-eth0 -s 30.0.0.1 00:33:00:00:00:03')


    h4 = net.get( 'h4' )
    h4.cmd( 'ifconfig eth0:1 40.0.0.11/24')
    h4.cmd( 'ifconfig eth0:2 40.0.0.12/24')
    h4.cmd( 'ifconfig eth0:3 40.0.0.13/24')
    h4.cmd( 'ifconfig eth0:4 40.0.0.14/24')
    h4.cmd( 'ifconfig eth0:5 40.0.0.15/24')
    h4.cmd( 'ifconfig eth0:6 40.0.0.16/24')
    h4.cmd( 'ifconfig eth0:7 40.0.0.17/24')
    h4.cmd( 'ifconfig eth0:8 40.0.0.18/24')
    h4.cmd( 'ifconfig eth0:9 40.0.0.19/24')
    h4.cmd( 'ifconfig eth0:10 40.0.0.20/24')


    h4.setDefaultRoute("dev eth0 via 40.0.0.1")
    h4.cmd('arp -i eth0 -s 40.0.0.1 00:33:00:00:00:04')



    sleep(1)

    print "Ready !"

    CLI( net )
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    main()

