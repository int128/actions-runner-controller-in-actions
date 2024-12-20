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
	kubectl get pods -n arc-systems

.PHONY: wait-for-job
wait-for-job:
	while ! kubectl wait pods -n arc-runners --all --for=condition=Ready; do sleep 1; done
	kubectl get pods -n arc-runners
	-kubectl logs -n arc-runners -l app.kubernetes.io/component=runner --tail=-1 -f

# Unregister runners and runner sets from GitHub
.PHONY: undeploy
undeploy:
	kubectl delete -n arc-runners --all AutoscalingRunnerSet

.PHONY: listener-logs
listener-logs:
	-kubectl logs -n arc-systems -l app.kubernetes.io/component=runner-scale-set-listener --tail=-1

.PHONY: controller-logs
controller-logs:
	-kubectl logs -n arc-systems -l app.kubernetes.io/component=controller-manager --tail=-1
