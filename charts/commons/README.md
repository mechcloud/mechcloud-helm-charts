# MechCloud Commons
## Create Storage Class (Required only if you will be using mongodb included in this chart)
```
cat <<EOF >storageClass.yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: standard
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
EOF

kubectl apply -f storageClass.yaml
```

## Create PV (Required only if you will be using mongodb included in this chart)
```
sudo mkdir -p /mnt/data/mechcloud

cat <<EOF >mechcloud-pv.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mechcloud-pv
  labels:
    type: local
spec:
  storageClassName: standard
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data/mechcloud"
EOF

kubectl apply -f mechcloud-pv.yaml
```

## Create docker registry secret (Required only if you will be pulling docker images from a private registry)
```
docker login

K8_NAMESPACE=mechcloud-commons
kubectl create ns $K8_NAMESPACE

kubectl -n $K8_NAMESPACE create secret generic docker-reg-creds \
    --from-file=.dockerconfigjson=<absolute/path/to/.docker/config.json> \
    --type=kubernetes.io/dockerconfigjson
```

## Deploying MechCloud Commons
* Make sure [helm 3](https://helm.sh/docs/intro/install) client is installed in an environment where you will be executing these instructions from.
* Clone this repository.
```
git clone -b <branch_or_tag> git@github.com:mechcloud/mechcloud-helm-charts.git
```

## Deployment options
* This helm chart will be installing community version of mongodb in the target namespace.
* If you want to use external mongodb instance, simply update mongodb details in `mechcloud-helm-charts/charts/commons/values.yaml` file as per your target deployment.
* Update `setupAdmin` in `mechcloud-helm-charts/charts/commons/values.yaml` file with an email of a user (e.g. platformadmin@mechcloud.io) who should be admin of `platform` application. 

## Deploying helm chart
* Execute following commands to deploy MechCloud Commons -
```
cd mechcloud-helm-charts/charts/commons
K8_NAMESPACE=mechcloud-commons
helm -n $K8_NAMESPACE upgrade -i $K8_NAMESPACE --create-namespace . -f ../../values.yaml
```

## (Optional)Initialize MongoDB replicaset
* This is required only if you go ahead with mongodb instance included in this helm chart.
```
# Find out mongodb pod name and execute following commands -
kubectl exec -it <mongodb_pod_name> sh
> mongo -u admin -p
rs.initiate()
```

## Need help?
* Please report any issue related to deployment here.

