# GKE_DICOM_MLLP
Terraform for GKE with DICOM and MLLP adapter deplyments

<p align="center">
  <a href="" rel="noopener">
</p>

<h3 align="center">MLLP and DICOM adapter Generic deployments in GKE</h3>

---

## 📝 Table of Contents

- [Audience](#Audience)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting_started)
- [Built Using](#built_using)
- [CI/CD](#cicd)
- [Authors](#authors)

---

## Audience

Intended for use in healthcare engagements where the DICOM and MLLP adapters are required. Please refer to the latest Adapters [MLLP](https://github.com/GoogleCloudPlatform/mllp) and [DICOM] (https://github.com/GoogleCloudPlatform/healthcare-dicom-dicomweb-adapter) before deploying and modify as necessary.

---

## 🌡️ Prerequisites <a name = "prerequisites"></a>

- Shared VPC ([Shared VPC](https://cloud.google.com/vpc/docs/shared-vpc) )
- [Remote](https://www.terraform.io/language/settings/backends/gcs) State Bucket for TF 
- 

---

## 🏁 Getting Started <a name = "getting_started"></a>

Check [cluster](https://kubernetes.io/docs/reference/glossary/?all=true#term-cluster) context (IMPORTANT!):
Also make sure that Rancher is open (this can be seen via rancher logo in the tab in the top toolbar of ones computer)

```shell
kubectl config current-context
```

Expected Output:

```shell
rancher-desktop
```

Find out what [nodes](https://kubernetes.io/docs/reference/glossary/?all=true#term-node) are in the cluster:

```shell
kubectl get nodes
```

Expected Output:

```shell
NAME                   STATUS   ROLES                          AGE   VERSION
lima-rancher-desktop   Ready    builder,control-plane,master   11d   v1.23.1+k3s2
```

More information on the nodes can be found by adding `-o wide` at the end of the command:  

```shell
NAME                   STATUS   ROLES                  AGE   VERSION        INTERNAL-IP      EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
lima-rancher-desktop   Ready    control-plane,master   10d   v1.23.1+k3s2   192.168.128.23   <none>        Alpine Linux v3.14   5.10.88-0-virt   containerd://1.5.8-k3s2
```

If you wanted to go in-depth on the details for a node, `kubectl describe node <YOUR_NODE_NAME>` can be used:

```shell
kubectl describe node lima-rancher-desktop
```

The *[`describe`](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#describe)* option lists out the configuration of the node, events logged from the node, and its performance metrics. Describe will also work on all resources listed in the [Kubernetes API](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.23/#list-of-resources).

Next we can create a [namespace](https://kubernetes.io/docs/reference/glossary/?all=true#term-namespace) that your application will be running inside of:

```shell
kubectl create namespace <YOUR_NAMESPACE>
```

Expected Output:

```shell
namespace/<YOUR_NAMESPACE> created
```

Setting your [context](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/) to use the new namespace:

```shell
kubectl config set-context --current --namespace <YOUR_NAMESPACE>
```

Now `cd` into [kubernetes/](https://github.com/MavenWave-DevOps/ignite-walker/tree/main/kubernetes) and follow it's README to continue by deploying some basic workloads!

## ⛏️ Tools <a name = "built_using"></a>

- [Kubernetes](https://kubernetes.io/) - Container Orchestration
- [Rancher Desktop](https://rancherdesktop.io/) - Local Kubernetes
- [Helm](https://helm.sh/) - Manage Kubernetes Resources
- [Terraform](https://terraform.io/) - Cloud IaC
- [Kubebuilder](https://book.kubebuilder.io/)
- [Google Cloud Platform](https://www.cloud.google.com/)

## 🚀 CI/CD Lifecycles <a name = "cicd"></a>

The following directories have programs that can be containerized and deployed to kubernetes:

- [go/wiki-server](https://github.com/theboarderline/operators/tree/ops/go/wiki-server)
- [go/wiki-operator](https://github.com/theboarderline/operators/tree/ops/go/wiki-operator)

The following branches have Cloud Build triggers and Terraform Pipelines attached:

- `ops`
- `dev`
- `test`
- `stage`
- `main`

Whether triggers, IPs, and DNS entries are created for a lifecycle depends on the bool value: `disabled` found in the corresponding file found [here](https://github.com/MavenWave-DevOps/ignite-walker/tree/ops/terraform/vars) in the corresponding branch

## ✍️ Authors <a name = "authors"></a>

- [@ryanlee](https://github.com/ryanleemw)