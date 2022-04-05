# MechCloud Helm Charts

## Deploying charts
* Make sure you have MongoDB and Redis running somewhere as these are NOT included with `MechCloud` helm charts.
* Update details of MongoDB and Redis in `demo_overrides.yaml` file.
* If you want to use `oauth2-proxy` included in this repository then register an application in an OpenID Connect provider of your choice and update details of registered application (e.g. Client ID, Client Secret etc) under `oauth2Proxy.oauth2Provider.proxy` section of `demo_overrides.yaml` file.
* Create a user (e.g. platformadmin@mechcloud.io) in the OpenID Connect provider of your choice. This user will be admin of `platform` application.
* Update id of newly created user against `platform.authorization.setupAdmin` property in `demo_overrides.yaml` file.
* Create an environment file with following content and adjust values of various environment variables in it according to your target setup -
```
#!/bin/bash

export MONGO_USER=
export MONGO_PWD=
# A random string to encrypt sensitive data before persisting in DB
export ENCRYPTION_KEY=
```
* Deploy `MechCloud` using following command -
```
./deploy.sh demo
```

MechCloud documentation - https://docs.mechcloud.io

