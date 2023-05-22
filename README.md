# actions-runner-controller-in-actions [![run](https://github.com/int128/actions-runner-controller-in-actions/actions/workflows/run.yaml/badge.svg)](https://github.com/int128/actions-runner-controller-in-actions/actions/workflows/run.yaml)

This repository contains a test script to run [actions/actions-runner-controller](https://github.com/actions/actions-runner-controller) and [`RunnerScaleSet`](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/deploying-runner-scale-sets-with-actions-runner-controller) in GitHub Actions.

It depends on the following stack:

- Actions Runner Controller (ARC)
- Runner scale sets
- Helmfile
- Kind
- GitHub Actions

Here is the diagram.

```mermaid
graph TB
  subgraph GitHub hosted runner
    subgraph Kind cluster
      subgraph arc-systems namespace
        Controller
      end
      Controller --manage--> Runner
      subgraph arc-runners namespace
        Runner
      end
    end
  end
  GitHubActionsJob --runs-on--> Runner
```
