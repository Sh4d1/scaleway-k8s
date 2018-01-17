Fork
=========
This is a fork from chmod666org/scaleway-k8s.
My fork uses Debian Stretch, ARM architecture, Rook/Ceph storage, and Traefik as a Kubernetes Ingress.

Setup
=========
```
git clone https://github.com/Sh4d1/scaleway-k8s.git
cd scaleway-k8s/terraform
```
Terraform
=========
```
terraform apply
rm -rf ~/.ssh/known_hosts
ssh-keyscan $(terraform output -json public_ip | jq -r '.value[0]') > ~/.ssh/known_hosts
export ANSIBLE_HOST_KEY_CHECKING=false
export public_ip=$(terraform output -json public_ip | jq -r '.value[0]')
```

Ansible
=======
To install the k8s cluster run:

```
cd ..

ANSIBLE_HOST_KEY_CHECKING=false "scaleway_token=SCW_TOKEN scaleway_orga=SCW_ORGA basic_auth_user=MYUSER basic_auth_password=MYPASSWORD" ansible-playbook -i inventories/scaleway.inv k8s.yml
```

Replace:
  - SCW_TOKEN by your Scaleway token
  - SCW_ORGA by your Scaleway organization
  - basic_auth_user: by a username if you want the k8s dashboard to be protected by a basic auth
  - basic_auth_password: by a password if you want the k8s dashboard to be protected by a basi auth 

_scaleway_token_ and _scaleway_orga_ extra vars are only needed if you want an HA ingress. They allow _keepalived_ to move your Scaleway floating ip on a running proxy if one of the proxy fails.
_basic_auth_user_ and _basic_auth_password_ extra vars are only needed if you want the k8s dashbaord to be proctect by a basic_auth. Set basic_auth to True in roles/kubernetes_dashboard/defaults/main.yml to enable basic auth.

Dynamic Inventory
================
