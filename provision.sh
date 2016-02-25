#!/bin/sh

# install openvswitch
yum install -y https://rdo.fedorapeople.org/openstack/openstack-kilo/rdo-release-kilo.rpm
yum install -y openvswitch

systemctl start openvswitch
systemctl status openvswitch
ovs-vsctl show
