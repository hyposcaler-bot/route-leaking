ip addr add 10.255.40.14/24 dev eth1

ip route add 10.255.10.0/24 via 10.255.40.1 dev eth1
ip route add 10.255.20.0/24 via 10.255.40.1 dev eth1
ip route add 10.255.30.0/24 via 10.255.40.1 dev eth1
ip route add 10.255.50.0/24 via 10.255.40.1 dev eth1