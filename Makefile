.PHONY: deploy destroy reset status

deploy:
	containerlab deploy -t leak.clab.yml --reconfigure

destroy:
	containerlab destroy -t leak.clab.yml --cleanup

reset: destroy deploy

status:
	@containerlab inspect 2>&1 | grep -q "containers not found" && echo "Topology not deployed" || containerlab inspect


