#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#       __________  __ ___       _____    ________            
#      / ____/ __ \/ // / |     / /   |  /  _/ __ \____  _____
#     / /   / /_/ / // /| | /| / / /| |  / // / / / __ \/ ___/
#    / /___/ ____/__  __/ |/ |/ / ___ |_/ // /_/ / /_/ (__  ) 
#    \____/_/      /_/  |__/|__/_/  |_/___/\____/ .___/____/  
#                                              /_/            
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------"
#  CP4WAIOPS 3.2 - Monitor Kafka Topics
#
#
#  ©2021 nikh@ch.ibm.com
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
clear

echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "  "
echo "  🚀 CloudPak for Watson AIOps 3.2 - Monitor Kafka Topics"
echo "  "
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "  "
echo "  "
export TEMP_PATH=~/aiops-install

echo "  Initializing......"



WAIOPS_PARAMETER=$(cat ./00_config_cp4waiops.yaml|grep WAIOPS_NAMESPACE:)
WAIOPS_NAMESPACE=${WAIOPS_PARAMETER##*:}
WAIOPS_NAMESPACE=$(echo $WAIOPS_NAMESPACE|tr -d '[:space:]')

export LOG_TYPE=humio   # humio, elk, splunk, ...
export EVENT_TYPE=noi   # humio, elk, splunk, ...











































#!/bin/bash
menu_option_1 () {
  echo "Kafka Topics"
  oc get kafkatopic -n $WAIOPS_NAMESPACE

}

menu_option_2() {
  echo "Monitor Incidents"
  
  echo "	Press CTRL-C to stop "

  ${KAFKACAT_EXE} -v -X security.protocol=SASL_SSL -X ssl.ca.location=./ca.crt -X sasl.mechanisms=SCRAM-SHA-512 -X sasl.username=$SASL_USER -X sasl.password=$SASL_PASSWORD -b $BROKER -o -10 -C -t cp4waiops-cartridge.incident 

}


menu_option_3() {
  echo "Monitor $EVENTS_TOPIC"
  
  echo "	Press CTRL-C to stop "

  ${KAFKACAT_EXE} -v -X security.protocol=SASL_SSL -X ssl.ca.location=./ca.crt -X sasl.mechanisms=SCRAM-SHA-512 -X sasl.username=$SASL_USER -X sasl.password=$SASL_PASSWORD -b $BROKER -o -10 -C -t $EVENTS_TOPIC

}


menu_option_4() {
  echo "Monitor $LOGS_TOPIC"
  
  echo "	Press CTRL-C to stop "

  ${KAFKACAT_EXE} -v -X security.protocol=SASL_SSL -X ssl.ca.location=./ca.crt -X sasl.mechanisms=SCRAM-SHA-512 -X sasl.username=$SASL_USER -X sasl.password=$SASL_PASSWORD -b $BROKER -o -10 -C -t $LOGS_TOPIC 

}

menu_option_9() {
  echo "Monitor Specific Topic"
  oc get kafkatopic -n $WAIOPS_NAMESPACE
  read -p "Copy Paste Topic from above: " MY_TOPIC

  ${KAFKACAT_EXE} -v -X security.protocol=SASL_SSL -X ssl.ca.location=./ca.crt -X sasl.mechanisms=SCRAM-SHA-512 -X sasl.username=$SASL_USER -X sasl.password=$SASL_PASSWORD -b $BROKER -o -10 -C -t $MY_TOPIC
}




clear



echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "  "
echo "  🚀 CloudPak for Watson AIOps 3.2 - Monitor Kafka Topics"
echo "  "
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "  "
echo "  "

echo "  Initializing......"
if [ -x "$(command -v kafkacat)" ]; then
    export KAFKACAT_EXE=kafkacat
else
    if [ -x "$(command -v kcat)" ]; then
        export KAFKACAT_EXE=kcat
    else
        echo "      ❗ ERROR: kafkacat/kcat is not installed."
        echo "      ❌ Aborting..."
        exit 1
    fi
fi

  oc extract secret/kafka-secrets -n $WAIOPS_NAMESPACE --keys=ca.crt --confirm

  export SASL_USER=$(oc get secret ibm-aiops-kafka-secret -n $WAIOPS_NAMESPACE --template={{.data.username}} | base64 --decode)
  export SASL_PASSWORD=$(oc get secret ibm-aiops-kafka-secret -n $WAIOPS_NAMESPACE --template={{.data.password}} | base64 --decode)
  export BROKER=$(oc get routes iaf-system-kafka-0 -n $WAIOPS_NAMESPACE -o=jsonpath='{.status.ingress[0].host}{"\n"}'):443


echo "***************************************************************************************************************************************************"
echo "  "

export LOGS_TOPIC=$(oc get kafkatopics.ibmevents.ibm.com -n $WAIOPS_NAMESPACE | grep logs-$LOG_TYPE| awk '{print $1;}')
export EVENTS_TOPIC=$(oc get kafkatopics.ibmevents.ibm.com -n $WAIOPS_NAMESPACE | grep alerts-$EVENT_TYPE| awk '{print $1;}')


until [ "$selection" = "0" ]; do
  
  echo ""
  
  echo "  🔎 Observe Kafka Topics "
  echo "    	1  - Get Kafka Topics"
  echo "    	2  - Monitor Incidents"
  echo "    	3  - Monitor $EVENTS_TOPIC"
  echo "    	4  - Monitor $LOGS_TOPIC"
  echo "    	9  - Monitor Specific Topic"
  echo "      "
  echo "    	0  -  Exit"
  echo ""
  echo ""
  echo "  Enter selection: "
  read selection
  echo ""
  case $selection in
    1 ) clear ; menu_option_1  ;;
    2 ) clear ; menu_option_2  ;;
    3 ) clear ; menu_option_3  ;;
    4 ) clear ; menu_option_4  ;;
    9 ) clear ; menu_option_9  ;;

    0 ) clear ; exit ;;
    * ) clear ; incorrect_selection  ;;
  esac
done






