# Terraform Kustomization Shepard

The `terraform-kustomization-shepard` uses Kustomize manifests
to install [Shepard][] on any [Kubernetes][] cluster.

### Important
**The module is in an VERY early stage of development. Thus, it is 
experimental and not for production use.**

## Getting Started
Nobody wants complicated installations. We neither, so we try to keep 
things as simple as possible. So how does it work?

### Prerequisites
In fact, all it takes is a running [Kubernetes][] cluster to get started.
With [k3d][] you can do it like this, for example

```sh
k3d cluster create shepard-cluster
```

### Installation
In `./examples/kubernetes` you find a [Terraform][] script to install 
[Shepard][] on your configured [Kubernetes][] cluster. And this is how it 
works:

```sh
git clone https://github.com/WOGRA-AG/terraform-kustomization-kubeflow
cd terraform-kustomization-kubeflow/examples/kubernetes
terraform init
terraform apply -auto-approve
```

## 	Acknowledgment
This module was originally created by the ml research team at [WOGRA AG][] 
to deploy kubeflow as part of the [Os4ML][] project.

[Os4ML][] is a project of the [WOGRA AG][] research group in cooperation 
with the German Aerospace Center and is funded by the Ministry of Economic 
Affairs, Regional Development and Energy as part of the High Tech Agenda 
of the Free State of Bavaria.

[Terraform]: https://terraform.io/
[Kubernetes]: https://kubernetes.io/
[Shepard]: https://gitlab.com/dlr-shepard
[k3d]: https://k3d.io
[WOGRA AG]: https://www.wogra.com/
[Os4ML]: https://github.com/WOGRA-AG/Os4ML
[docs]: https://wogra-ag.github.io/os4ml-docs/