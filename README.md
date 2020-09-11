# sqlproxy-ssh-tunnel Helm chart

This is a simple SSH jumpserver to enable tunneling in to a Google Cloud SQL instance without a
public IP. The pod consists of an SSH server with a SQLproxy sidecar, exposed through a Loadbalancer.

Helm chart based on https://v3.helm.sh/docs/topics/chart_repository/#github-pages-example
and https://github.com/technosophos/tscharts.

Kubernetes templates and scripts based on:

- https://github.com/sickp/docker-alpine-sshd
- https://github.com/helm/charts/tree/master/stable/openvpn

## Repo URL

https://team-blaze.github.io/sqlproxy-ssh-tunnel

## Configuration

The following table lists the configurable parameters of the `sqlproxy-ssh-tunnel` chart and their
default values, and can be overwritten via the helm `--set` flag.

| Parameter                          | Description                                | Default                           |
| ---------------------------------- | ------------------------------------------ | --------------------------------- |
| `name`                             | Name to give to the k8s objects            | `sqlproxy-ssh-tunnel`             |
| `image`                            | Docker image and tag to use                | `berylcc/sqlproxy-ssh-tunnel:1.0` |
| `imagePullSecrets`                 | Docker registry secret                     | unset                             |
| `authorizedKeysBase64`             | Base64 encoded `authorized_keys`           | must be set                       |
| `hostKeyBase64`                    | Base64 encoded `ssh_host_ed25519_key`      | must be set                       |
| `cloudsql.project`                 | Docker registry secret                     | `my-project`                      |
| `cloudsql.region`                  | Docker registry secret                     | `us-west1`                        |
| `cloudsql.instance`                | Docker registry secret                     | `sql_instance`                    |
| `cloudsql.port`                    | Docker registry secret                     | 3306                              |
| `cloudsql.serviceAccountKeyBase64` | Base64 encoded Google service account JSON | must be set                       |
| `service.loadBalancerPort`         | Port you want to be exposed to the outside | 22                                |
| `service.loadBalancerIP`           | Load balancer IP (if pre-allocated)        | unset                             |

## Notes

There's an image hosted in Docker Hub built from the `Dockerfile` in this repo which will work, but
you might want to build and push into your private cloud registry. If you do so, you'll need to set
`imagePullSecrets` for Kubernetes to be authenticated to pull the image when deploying, see:
https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
