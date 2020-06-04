#!/bin/bash

# Install the aks-preview extension
az extension add --name aks-preview

# Update the extension to make sure you have the latest version installed
az extension update --name aks-preview

az feature register --name PodSecurityPolicyPreview --namespace Microsoft.ContainerService

az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/PodSecurityPolicyPreview')].{Name:name,State:properties.state}"
# wait until you have State = Registered

az provider register --namespace Microsoft.ContainerService



RESOURCE_GROUP_NAME=rg-aks-simple
CLUSTER_NAME=aks-simple2020
LOCATION=northeurope

az aks update \
    --resource-group $RESOURCE_GROUP_NAME \
    --name $CLUSTER_NAME \
    --enable-pod-security-policy


#az aks update \
#    --resource-group $RESOURCE_GROUP_NAME \
#    --name $CLUSTER_NAME \
#    --disable-pod-security-policy
