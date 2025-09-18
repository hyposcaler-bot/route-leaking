.PHONY: help deploy destroy reset status inspect save shell-leaf1 shell-client1 shell-client2 test-ping clean

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

deploy: ## Deploy the containerlab topology
	containerlab deploy -t leak.clab.yml --reconfigure

destroy: ## Destroy the containerlab topology
	containerlab destroy -t leak.clab.yml --cleanup

reset: destroy deploy ## Destroy and redeploy the topology

status: ## Quick status check of the topology
	@containerlab inspect 2>&1 | grep -q "containers not found" && echo "Topology not deployed" || containerlab inspect

inspect: ## Inspect the running lab with detailed information
	containerlab inspect -t leak.clab.yml

save: ## Save configurations from running containers
	containerlab save -t leak.clab.yml

shell-leaf1: ## Connect to leaf1 CLI
	docker exec -it clab-leak-leaf1 sr_cli

shell-client1: ## Connect to client1 shell
	docker exec -it clab-leak-client1 bash

shell-client2: ## Connect to client2 shell
	docker exec -it clab-leak-client2 bash

test-ping: ## Test connectivity between clients
	@echo "Testing ping from client1 to client2..."
	docker exec clab-leak-client1 ping -c 3 10.255.20.12
	@echo "Testing ping from client2 to client1..."
	docker exec clab-leak-client2 ping -c 3 10.255.10.11

clean: ## Clean up all lab artifacts
	containerlab destroy -t leak.clab.yml --cleanup
	rm -rf clab-leak/

.DEFAULT_GOAL := help


