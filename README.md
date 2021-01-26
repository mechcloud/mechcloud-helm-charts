# mechcloud-helm-charts
MechCloud Helm Charts

## Deploying charts
* Register an application in an OpenID Connect provider of your choice and note down relevant details.
* Create at least two users in OpenID Connect provider - one of these user will be admin of `platform` application while other user will act as a tenant admin for the tenant created in `platform` application.
* Follow README files located in the root folder of individual charts in the following order -
  - oauth2-proxy
  - commons
  - platform
  - mechcloud-ui
* Access `platform` application (e.g. https://demo.mechcloud.lab/platform), login using platform admin credentials, onboard tenant admin user created in previous steps and create a tenant (e.g. tenant1) with newly onboarded user as tenant admin.
* Access newly created tenant (e.g. https://demo.mechcloud.lab/tenant1) and login using platform admin credentials.

