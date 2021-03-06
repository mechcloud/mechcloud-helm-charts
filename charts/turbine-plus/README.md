# MechCloud Turbine+
## Deploying MechCloud Turbine+
* Make sure [helm 3](https://helm.sh/docs/intro/install) client is installed in an environment where you will be executing these instructions from.
* Clone this repository.
```
git clone -b <branch_or_tag> git@github.com:mechcloud/mechcloud-helm-charts.git
```

## (Optional)Create docker registry secret
```
docker login

K8_NAMESPACE=mechcloud-turbine-plus

kubectl -n $K8_NAMESPACE create secret generic docker-reg-creds \
    --from-file=.dockerconfigjson=<absolute/path/to/.docker/config.json> \
    --type=kubernetes.io/dockerconfigjson
```

## Deploy helm chart
* Execute following commands to deploy MechCloud Turbine+ -
```
cd mechcloud-helm-charts/charts/turbine-plus
K8_NAMESPACE=mechcloud-turbine-plus
helm -n $K8_NAMESPACE upgrade -i $K8_NAMESPACE --create-namespace . -f ../../values.yaml
```

## Need help?
* Please report any issue related to deployment here.

