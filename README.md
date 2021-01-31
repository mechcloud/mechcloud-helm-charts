# mechcloud-helm-charts
MechCloud Helm Charts

## Deploying charts
* Register an application in an OpenID Connect provider of your choice and update values in `charts\oauth2-proxy\values.yaml` file according to your set up.
* Create at least two users (e.g. platformadmin@mechcloud.io, tenant1admin@mechcloud.io) in the  OpenID Connect provider - one of these users (e.g. platformadmin@mechcloud.io) will be admin of `platform` application while other user (e.g. tenant1admin@mechcloud.io) will be admin of the tenant created through `platform` application.
* Follow README files located in the root folder of individual charts in the following order -
  - oauth2-proxy
  - commons
  - platform
  - turbine-plus
* Access `platform` application (e.g. https://demo.mechcloud.lab/platform), login using platform admin credentials and perform following steps-
  - Register tenant admin user created in previous step.
  - Create a tenant (e.g. tenant1) selecting newly onboarded user as tenant admin.
* Access newly created tenant (e.g. https://demo.mechcloud.lab/tenant1) and login using tenant admin credentials.

