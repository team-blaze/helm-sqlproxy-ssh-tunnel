# sqlproxy-ssh-tunnel Helm chart

TODO

Helm chart based on https://v3.helm.sh/docs/topics/chart_repository/#github-pages-example
and https://github.com/technosophos/tscharts.

Kubernetes templates and scripts based on:

- https://github.com/sickp/docker-alpine-sshd
- https://github.com/kubernetes-contrib/jumpserver
- https://github.com/helm/charts/tree/master/stable/openvpn

## Repo URL

https://team-blaze.github.io/sqlproxy-ssh-tunnel

## Configuration

The following table lists the configurable parameters of the `sqlproxy-ssh-tunnel` chart and their
default values, and can be overwritten via the helm `--set` flag.

| Parameter          | Description                 | Default                           |
| ------------------ | --------------------------- | --------------------------------- |
| `image`            | Docker image and tag to use | `berylcc/sqlproxy-ssh-tunnel:1.0` |
| `imagePullSecrets` | Docker registry secret      | unset                             |

There's an image hosted in Docker Hub built from the `Dockerfile` in this repo which will work, but
you might want to build and push into your private cloud registry. If you do so, you'll need to set
`imagePullSecrets` for Kubernetes to be authenticated to pull the image when deploying, see:
https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
