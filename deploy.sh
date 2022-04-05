#!/bin/bash

if [[ -z "$1" ]]; then
	echo 'Target environment prefix is missing. Expected command : ./deploy.sh <environment_prefix>. Example : ./deploy.sh demo'
	exit 0
fi

apps=$2
if [[ -z "$2" ]]; then
	apps=all
fi

export CHARTS_HOME=`pwd`

# MongoDB
MONGO_USER=$MONGO_USER
MONGO_PWD=$MONGO_PWD

# MechCloud
ENCRYPTION_KEY=$ENCRYPTION_KEY

# Validate mongo environment variables
if [[ -z "$MONGO_USER" || -z "$MONGO_PWD" ]]; then
	echo 'Mongo settings are missing'
	exit 0
fi

# Validate mechcloud environment variables
if [[ -z "$ENCRYPTION_KEY" ]]; then
	echo 'Mechcloud settings (e.g. ENCRYPTION_KEY etc) are missing'
	exit 0
fi

# =====> Deploy oauth2-proxy
if [[ "$apps" == "all" || "$apps" == *"oauth2-proxy"* ]]; then
	cd $CHARTS_HOME/charts/oauth2-proxy
	
	K8_NAMESPACE=mechcloud-oauth2-proxy
	kubectl create ns $K8_NAMESPACE
	
	kubectl -n $K8_NAMESPACE delete deployments --all

	helm -n $K8_NAMESPACE upgrade -i $K8_NAMESPACE --create-namespace . -f ../../$1_overrides.yaml
fi

# =====> Deploy Commons
if [[ "$apps" == "all" || "$apps" == *"commons"* ]]; then
	cd $CHARTS_HOME/charts/commons
	
	K8_NAMESPACE=mechcloud-commons
	kubectl create ns $K8_NAMESPACE
	
	kubectl -n $K8_NAMESPACE delete deployments --all

	helm -n $K8_NAMESPACE upgrade -i $K8_NAMESPACE --create-namespace . -f ../../values.yaml -f ../../$1_overrides.yaml \
		--set global.mongo.username=$MONGO_USER \
		--set global.mongo.pwd=$MONGO_PWD \
		--set global.shared.encryptionKey=$ENCRYPTION_KEY
fi

# =====> Deploy Platform
if [[ "$apps" == "all" || "$apps" == *"platform"* ]]; then
	cd $CHARTS_HOME/charts/platform
	
	K8_NAMESPACE=mechcloud-platform
	kubectl create ns $K8_NAMESPACE
	
	kubectl -n $K8_NAMESPACE delete deployments --all

	helm -n $K8_NAMESPACE upgrade -i $K8_NAMESPACE --create-namespace . -f ../../values.yaml -f ../../$1_overrides.yaml \
		--set global.shared.encryptionKey=$ENCRYPTION_KEY
fi

# =====> Deploy Turbine
if [[ "$apps" == "all" || "$apps" == *"turbine"* ]]; then
	cd $CHARTS_HOME/charts/turbine
	
	K8_NAMESPACE=mechcloud-turbine
	kubectl create ns $K8_NAMESPACE
	
	kubectl -n $K8_NAMESPACE delete deployments --all

	helm -n $K8_NAMESPACE upgrade -i $K8_NAMESPACE --create-namespace . -f ../../values.yaml -f ../../$1_overrides.yaml \
		--set global.shared.encryptionKey=$ENCRYPTION_KEY
fi

