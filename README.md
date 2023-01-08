# P4-RESISTING-bmv2

This repository contains the P4 based implementation of RESISTING for BMv2 and running scripts.

### Quick Start:
* Compile the P4 RESISITING for bmv2 using the `p4c` compiler
* Execute the RESISTING program using the mininet with simple_switch software switch  
* Add table and register entries to the running the RESISTING program
* Send packets to the running the RESISTING program using the hosts (h1,h2,h3) and testing the FRR ECMP mechanism running link faliures 

### Network Topology 
<img src="top-spine-leaf.jpg" alt="Topologia Spine-Leaf">

### Installation and Compiling
clone P4-RESISTING-bmv2
```
git clone https://github.com/danielbl1000/P4-RESISTING-bmv2.git
```
<img src="/figs/fig01.jpg" alt="Clone">
To compile RESISTING code:
```
cd P4-RESISTING-bmv2/src/
```
```
./p4c_bmv2_6p_frr_v2_resisting.sh
```
<img src="/figs/fig02.jpg" alt="Compiling">



