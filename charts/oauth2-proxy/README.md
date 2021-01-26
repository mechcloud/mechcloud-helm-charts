# OAuth2 Proxy
## Deploying OAuth2 Proxy
* Make sure [helm 3](https://helm.sh/docs/intro/install) client is installed in an environment where you will be executing these instructions from.
* Clone this repository.
```
git clone -b <branch_or_tag> git@github.com:mechcloud/mechcloud-helm-charts.git
```

## Deployment options
* Execute following commands to deploy OAuth2 Proxy -
```
cd mechcloud-helm-charts/charts/oauth2-proxy
K8_NAMESPACE=oauth2-proxy
helm -n $K8_NAMESPACE upgrade -i $K8_NAMESPACE --create-namespace . -f ../../values.yaml
```

## Need help?
* Please report any issue related to deployment here.

