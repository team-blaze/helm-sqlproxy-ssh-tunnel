# sqlproxy-ssh-tunnel Helm chart

This is a simple SSH jumpserver to enable tunneling in to a Google Cloud SQL instance without a
public IP. The pod consists of an SSH server with a SQLproxy sidecar, exposed through a Loadbalancer.

There's also an optional SSH client container for setting up a reverse SSH tunnel.

NOTE: to keep things more secure, only ED25519 keys are used in the chart.

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
| `sshd_config`                      | SSH server configuration                   | see `values.yaml`                 |
| `cloudsql.serviceAccountKeyBase64` | Base64 encoded Google service account JSON | must be set                       |
| `cloudsql.instances[0].project`    | Cloud SQL instance project                 | `my-project`                      |
| `cloudsql.instances[0].region`     | Cloud SQL instance region                  | `us-west1`                        |
| `cloudsql.instances[0].instance`   | Cloud SQL instance name                    | `sql_instance`                    |
| `cloudsql.instances[0].port`       | Port to bind Cloud SQL instance to         | 3306                              |
| `service.loadBalancerPort`         | Port you want to be exposed to the outside | 22                                |
| `service.loadBalancerIP`           | Load balancer IP (if pre-allocated)        | unset                             |
| `reverseTunnel.privateKeyBase64`   | Base64 encoded `ssh_client_ed25519_key`    | unset                             |
| `reverseTunnel.sshUser`            | Reverse tunnel server user                 | unset                             |
| `reverseTunnel.sshHost`            | Reverse tunnel server host                 | unset                             |
| `reverseTunnel.remoteDbPort`       | Reverse tunnel server database port        | unset                             |
| `reverseTunnel.localDbPort`        | Cloud SQL instance port                    | unset                             |

NOTE: you can proxy multiple Cloud SQL instances (like read replicas), but make sure to bind each
instance to a different port.

## Usage

Once you have your chart up and running, you can SSH in and forward the SQL server port with a command like:

```sh
ssh sshuser@$SSH_SERVER_ADDRESS -i id_ed25519 -L 3306:127.0.0.1:3306 -o ExitOnForwardFailure=yes
```

## Notes

There's an image hosted in Docker Hub built from the `Dockerfile` in this repo which will work, but
you might want to build and push into your private cloud registry. If you do so, you'll need to set
`imagePullSecrets` for Kubernetes to be authenticated to pull the image when deploying, see:
https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
