#!/bin/sh

# install openvswitch
yum install -y https://rdo.fedorapeople.org/openstack/openstack-kilo/rdo-release-kilo.rpm
yum install -y openvswitch

systemctl start openvswitch
systemctl status openvswitch
ovs-vsctl show

## Network Namespaceの作成
# ip netns add qrouter1
## veth pearの作成
# ip link add qr-veth1 type veth peer name qr-peer1
# ip link set qr-veth1 netns qrouter1

## スイッチの作成及び接続
# ovs-vsctl add-br br-int
# ovs-vsctl add-port br-int qr-peer1

## Network Namespaceの作成
# ip netns add qvm1
## veth pearの作成
# ip link add vm-veth1 type veth peer name vm-peer1
# ip link set vm-veth1 netns qvm1

## スイッチの接続
# ovs-vsctl add-port br-int vm-peer1

## state up
# ip netns exec qrouter1 ip addr add 10.0.0.1/21 dev qr-veth1
# ip netns exec qvm1 ip addr add 10.0.0.3/21 dev vm-veth1
# ip link set qr-peer1 up
# ip link set vm-peer1 up
# ip link set br-int up
# ip link set ovs-system up
# ip netns exec qvm1 ip link set vm-veth1 up
# ip netns exec qvm1 ip link set lo up
# ip netns exec qrouter1 ip link set qr-veth1 up
# ip netns exec qrouter1 ip link set lo up

# check network
# ip netns exec qvm1 ping 10.0.0.1





# ip link add qg-veth1 type veth peer name qg-peer1
# ip link set qg-veth1 netns qrouter1
# ovs-vsctl add-br br-ex
# ovs-vsctl add-port br-ex qg-peer1
# ip netns exec qrouter1 sysctl net.ipv4.ip_forward=1

# ip netns exec qrouter1 ip addr add 10.0.2.20/24 dev qg-veth1
# ip netns exec qrouter1 ip addr add 10.0.2.21/24 dev qg-veth1
# ip link set qg-peer1 up
# ip link set br-ex up
# ip netns exec qrouter1 ip link set qg-veth1 up
# ip netns exec qrouter1 iptables -t nat -A POSTROUTING -s 10.0.0.3 -j SNAT --to 10.0.2.21
# ip netns exec qrouter1 iptables -t nat -A PREROUTING -d 10.0.2.21 -j DNAT --to 10.0.0.3
# ip netns exec qrouter1 iptables -t nat -nL

# ip netns exec qvm1 ip route add default via 10.0.0.1 dev vm-veth1
# ovs-vsctl add-port br-ex eth0


# check network
# ip netns exec qvm1 ping 8.8.8.8

