KUBECONFIG := kubeconfig.yaml
export KUBECONFIG

.PHONY: cluster
cluster:
	kind create cluster --name arc-cluster
	kubectl version

.PHONY: deploy
deploy:
	helmfile sync
	helm list -A
	kubectl rollout status deployment -n arc-systems arc-gha-runner-scale-set-controller
	kubectl get pods -n arc-systems

.PHONY: wait-for-job
wait-for-job:
	while true; do if kubectl get pods -n arc-runners | grep Running; then break; fi; sleep 1; done
	-kubectl logs -n arc-runners -l app.kubernetes.io/component=runner --tail=-1 -f

.PHONY: logs
logs:
	-kubectl logs -n arc-systems -l app.kubernetes.io/component=controller-manager --tail=-1
