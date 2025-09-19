# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a containerlab-based demonstration of VRF-lite inter-instance route leaking using Nokia SR Linux. The lab creates a simplified network topology to demonstrate L3VPN route leaking scenarios between different VRFs on a single switch.

## Architecture

### Current Topology (Simplified)
- **1 Nokia SR Linux switch** (leaf1): Configured with multiple VLANs and L3VPN instances
- **2 Linux clients** (client1, client2): End hosts for testing connectivity
- **VRF Configuration**: Bridge domains (VLANs 10, 20) with associated L3VPN instances for route leaking

### Key Components
- **Switch Configuration**: `configs/srlinux/leaf*.cfg` - SR Linux startup config with VRF and bridge instances
- **Client Scripts**: `configs/clients/client*.sh` - Linux client IP and routing configuration
- **Topology Definition**: `leak.clab.yml` - Containerlab topology specification

### Network Design
- **Client addressing**: 10.255.X.1Y/24 subnets where X is the VLAN number and Y is the client number
- **Subnet default gateways** 10.255.X.1 where X is the VLAN number.
- **Switch loopback**: 10.255.255.1/32
- **L3VPN instances**: Configured for potential route leaking between VRFs
- **Bridge domains**: MAC-VRF instances connecting VLANs to clients

## Common Commands

### Lab Management
```bash
# Install containerlab (requires sudo)
make install

# Deploy the lab
make deploy

# Check lab status
make status
make inspect

# Destroy the lab
make destroy

# Complete reset (destroy + deploy)
make reset

# Clean up all artifacts
make clean
```

### Testing and Access
```bash
# Test connectivity between clients
make test-ping

# Access device shells
make shell-leaf1    # Nokia SR Linux CLI
make shell-client1  # Client1 bash shell
make shell-client2  # Client2 bash shell

# Save running configurations
make save
```

### Direct Containerlab Commands
```bash
# Deploy with reconfiguration
containerlab deploy -t leak.clab.yml --reconfigure

# Inspect running topology
containerlab inspect -t leak.clab.yml

# Access devices directly
docker exec -it clab-leak-leaf1 sr_cli
docker exec -it clab-leak-client1 bash
```

## Configuration Structure

### Switch Configuration (`configs/srlinux/leaf1.cfg`)
- Interface definitions for client connections (e1-1, e1-2)
- IRB interfaces for VLAN gateways (irb0.10, irb0.20)
- Bridge instances (bridge-10, bridge-20) as MAC-VRFs
- L3VPN instances (l3vpn-10-30, l3vpn-20-40) for route leaking scenarios

### Client Configuration (`configs/clients/`)
- IP address assignment for each client
- Static routes to reach other subnets via switch gateway
- Basic connectivity testing setup

## Development Workflow

1. Modify configurations in `configs/` directory
2. Use `make reset` to apply changes (destroys and redeploys lab)
3. Test connectivity with `make test-ping`
4. Access devices with `make shell-*` commands for troubleshooting
5. Save configurations with `make save` if needed

## Dependencies

- **Containerlab**: Network lab orchestration tool
- **Docker**: Container runtime for network devices and clients
- **Nokia SR Linux image**: `ghcr.io/nokia/srlinux:25.3.2`
- **Linux multitool image**: `ghcr.io/srl-labs/network-multitool`