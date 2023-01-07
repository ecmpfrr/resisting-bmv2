echo "##########REGISTER S1##########"
sudo python /home/p4/behavioral-model/tools/runtime_CLI.py --thrift-port 9090 < sh-regs.sh
echo "_______________________________"
echo "##########REGISTER S2##########"
sudo python /home/p4/behavioral-model/tools/runtime_CLI.py --thrift-port 9091 < sh-regs.sh
echo "_______________________________"
echo "##########REGISTER S3##########"
sudo python /home/p4/behavioral-model/tools/runtime_CLI.py --thrift-port 9092 < sh-regs.sh
echo "_______________________________"
echo "_______________________________"
echo "##########REGISTER S11##########"
sudo python /home/p4/behavioral-model/tools/runtime_CLI.py --thrift-port 9093 < sh-regs-s11.sh
echo "_______________________________"
echo "##########REGISTER S12##########"
sudo python /home/p4/behavioral-model/tools/runtime_CLI.py --thrift-port 9095 < sh-regs-s12.sh
echo "_______________________________"

