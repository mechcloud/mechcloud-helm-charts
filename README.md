# MechCloud Helm Charts

## Features implemented in this release
Visualization of the following resources is supported in this release -

**AWS**
 * Regions / Zones
 * VPCs
 * Subnets
 * Virtual Machines

**IBM Cloud**
* VPC Networking
  - Regions/Zones
  - VPCs / Subnets
  - Virtual Machines
  - Kubenetes Clusters 
* Classic Networking
  - Metros / Datacenters
  - Vlans / Subnets
  - Virtual Machines / Bare Metal Servers
  - Kubernetes Clusters

## Deploying charts
* If you want to use `oauth2-proxy` included in this repository then register an application in an OpenID Connect provider of your choice and update details of registered application (e.g. Client ID, Client Secret etc) in `charts\oauth2-proxy\values.yaml` file according to your set up.
* If you want to use some other auth/sso proxy for api authentication/authorization then update value of `authProxy` to `false` and set value of `authUrl` in `values.yaml` file (located in the root folder of this repository) as per your target deployment.
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


## Addressing security concerns

![Recommended secure deployment](https://raw.githubusercontent.com/mechcloud/mechcloud-helm-charts/main/images/mechcloud-recommended-secure-setup.png)

* DON'T configure root user for your cloud account in this application. Use a service account for IBM Cloud and equivalent of it for AWS. Also make sure that these service accounts are having minimal read-only access ONLY to target public cloud api. This release requires read-only access to following resources -
  - VPC
  - Subnet
  - Virtual Servers
  - Kubernetes (Supported for IBM Cloud only in this release)

## Product documentation
Due to time constraint I am unable to create good documentation for MechCloud. However you can find detailed demos on [MechCloud Youtube Playlist](https://www.youtube.com/playlist?list=PLKIm9A1s_m4wgyo0IKHtKSuvOvrVYfric) which should help you to get started in a very short time.
  
