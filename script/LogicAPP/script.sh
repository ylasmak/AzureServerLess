#!/bin/bash
#set -e
#. ./params.sh

logicAppName="weateralertlogicapp"
weather_storage_account_name="iotweathersrore01"
office365_Connection_DisplayName="ylasmak@sqli.com"
email_to="ylasmak@gmail.com"
deploymentName="LogicAPPDeployment"
resource_group_name="iot-weather-alert"
logicapp_template_file="../../../LogicAPP/WeatherAlertLogicAPP/WeatherAlertLogicAPP/LogicAPP.json"

azurequeues_sharedkey=$(az storage account keys list \
                         --account-name  $weather_storage_account_name \
                         --query "[?contains(keyName, 'key1')].value" -o tsv)


echo "Start executing ARM deployment to create LogicAPP"
az deployment group create --resource-group $resource_group_name \
                            --name $deploymentName  \
                            --template-file $logicapp_template_file \
                            --parameters logicAppName=$logicAppName \
                              azurequeues_storageaccount=$weather_storage_account_name \
                              azurequeues_sharedkey=$azurequeues_sharedkey \
                              email_to=$email_to


