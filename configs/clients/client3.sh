ip addr add 10.255.30.13/24 dev eth1

ip route add 10.255.10.0/24 via 10.255.30.1 dev eth1
ip route add 10.255.20.0/24 via 10.255.30.1 dev eth1
ip route add 10.255.40.0/24 via 10.255.30.1 dev eth1
ip route add 10.255.50.0/24 via 10.255.30.1 dev eth1