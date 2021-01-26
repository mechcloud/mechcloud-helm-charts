# MechCloud Commons
## (Optional) Create Storage Class
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

## (Optional) Create PV
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

## (Optional)Create docker registry secret
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
* Execute following commands to deploy MechCloud Commons -
```
cd mechcloud-helm-charts/charts/commons
K8_NAMESPACE=mechcloud-commons
helm -n $K8_NAMESPACE upgrade -i $K8_NAMESPACE --create-namespace . -f ../../values.yaml
```

## Initialize MongoDB replicaset
```
# Find out mongodb pod name
kubectl exec -it <mongodb_pod_name> sh
> mongo -u admin -p
rs.initiate()
rs.status()
```

## Need help?
* Please report any issue related to deployment here.
* Issues related to application functionality can be reported in `https://github.com/mechcloud/mechcloud-commons` repository.

