echo "Starting..."
WAIOPS_PARAMETER=$(cat ./00_config_cp4waiops.yaml|grep WAIOPS_NAMESPACE:)
WAIOPS_NAMESPACE=${WAIOPS_PARAMETER##*:}
WAIOPS_NAMESPACE=$(echo $WAIOPS_NAMESPACE|tr -d '[:space:]')

CLUSTER_ROUTE=$(oc get routes console -n openshift-console | tail -n 1 2>&1 ) 
CLUSTER_FQDN=$( echo $CLUSTER_ROUTE | awk '{print $2}')
CLUSTER_NAME=${CLUSTER_FQDN##*console.}


export NOI_REST_USR=$(oc get secret aiops-topology-asm-credentials -n $WAIOPS_NAMESPACE -o=template --template={{.data.username}} | base64 --decode)
export NOI_REST_PWD=$(oc get secret aiops-topology-asm-credentials -n $WAIOPS_NAMESPACE -o=template --template={{.data.password}} | base64 --decode)

oc delete route topology-rest -n $WAIOPS_NAMESPACE 
oc create route passthrough topology-rest -n $WAIOPS_NAMESPACE --insecure-policy="Redirect" --service=aiops-topology-rest-observer --port=https-rest-observer-api

export LOGIN="$NOI_REST_USR:$NOI_REST_PWD"

echo "URL: https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources"
echo "LOGIN: $LOGIN"

echo "Wait 5 seconds"
sleep 5

#echo curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["deployment"],"mergeTokens": ["web"],"matchTokens": ["web","web-deployment"],"name": "web","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "web-id"}'



# -------------------------------------------------------------------------------------------------------------------------------------------------
# CREATE EDGES
# -------------------------------------------------------------------------------------------------------------------------------------------------
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["deployment"],"mergeTokens": ["web"],"matchTokens": ["web","web-deployment","web-synthetic","web-instana"],"name": "web","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "web-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["deployment"],"mergeTokens": ["shipping"],"matchTokens": ["shipping","shipping-deployment"],"name": "shipping","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "shipping-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["deployment"],"mergeTokens": ["cart"],"matchTokens": ["cart","cart-deployment"],"name": "cart","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "cart-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["deployment"],"mergeTokens": ["user"],"matchTokens": ["user","user-deployment"],"name": "user","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "user-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["deployment"],"mergeTokens": ["catalogue"],"matchTokens": ["catalogue","catalogue-deployment","catalogue-log"],"name": "catalogue","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "catalogue-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["deployment"],"mergeTokens": ["cities"],"matchTokens": ["cities","cities-deployment"],"name": "cities","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "cities-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["deployment"],"mergeTokens": ["redis"],"matchTokens": ["redis","redis-deployment"],"name": "redis","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "redis-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["deployment"],"mergeTokens": ["payment"],"matchTokens": ["payment","payment-deployment"],"name": "payment","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "payment-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["deployment"],"mergeTokens": ["dispatch"],"matchTokens": ["dispatch","dispatch-deployment"],"name": "dispatch","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "dispatch-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["deployment"],"mergeTokens": ["mongodb"],"matchTokens": ["mongodb","mongodb-deployment"],"name": "mongodb","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "mongodb-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["deployment"],"mergeTokens": ["rabbitmq"],"matchTokens": ["rabbitmq","rabbitmq-deployment"],"name": "rabbitmq","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "rabbitmq-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["deployment"],"mergeTokens": ["ratings"],"matchTokens": ["ratings","ratings-deployment","ratings-log","ratings-predictive"],"name": "ratings","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "ratings-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["deployment"],"mergeTokens": ["mysql"],"matchTokens": ["mysql","mysql-deployment","mysql-github","mysql-instana","mysql-security","mysql-predictive","mysql-turbonomic","xxx","xxx","xxx","xxx","xxx","xxx"],"matchTokens": ["mysql","mysql"],"name": "mysql","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "mysql-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["deployment"],"mergeTokens": ["load"],"matchTokens": ["load","load-deployment"],"name": "load","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "load-id"}'
echo "."



curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["server"],"matchTokens": ["paypal"],"name": "paypal.com","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "paypal.com-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["server"],"matchTokens": ["paypal"],"name": "www.paypal.com","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "www.paypal.com-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["volume"],"matchTokens": ["catalogue-db"],"name": "catalogue-db","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "catalogue-db-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/resources" --insecure -H 'Content-Type: application/json' -u $LOGIN -H 'JobId: listenJob' -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d $'{"app": "robotshop","availableReplicas": 1,"createdReplicas": 1,"dataCenter": "demo","desiredReplicas": 1,"entityTypes": ["volume"],"matchTokens": ["user-db"],"name": "user-db","namespace": "robot-shop","readyReplicas": 1,"tags": ["app:robotshop","namespace:robot-shop"],"vertexType": "resource","uniqueId": "user-db-id"}'
echo "."

echo "."



# -------------------------------------------------------------------------------------------------------------------------------------------------
# CREATE LINKS
# -------------------------------------------------------------------------------------------------------------------------------------------------
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "load-id","_toUniqueId": "web-id"}'
echo "."


curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "web-id","_toUniqueId": "shipping-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "web-id","_toUniqueId": "catalogue-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "web-id","_toUniqueId": "cart-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "web-id","_toUniqueId": "payment-id"}'
echo "."

curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "cart-id","_toUniqueId": "catalogue-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "cart-id","_toUniqueId": "redis-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "user-id","_toUniqueId": "redis-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "user-id","_toUniqueId": "mongodb-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "catalogue-id","_toUniqueId": "mongodb-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "ratings-id","_toUniqueId": "mysql-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "catalogue-id","_toUniqueId": "ratings-id"}'
echo "."

curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "shipping-id","_toUniqueId": "cart-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "cart-id","_toUniqueId": "payment-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "payment-id","_toUniqueId": "user-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "payment-id","_toUniqueId": "www.paypal.com-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "payment-id","_toUniqueId": "paypal.com-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "payment-id","_toUniqueId": "rabbitmq-id"}'
echo "."


curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "rabbitmq-id","_toUniqueId": "dispatch-id"}'
echo "."


curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "user-id","_toUniqueId": "user-db-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "catalogue-id","_toUniqueId": "catalogue-db-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "user-db-id","_toUniqueId": "mongodb-id"}'
echo "."
curl -X "POST" "https://topology-rest-$WAIOPS_NAMESPACE.$CLUSTER_NAME/1.0/rest-observer/rest/references" --insecure -H 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -H 'JobId: listenJob' -H 'Content-Type: application/json; charset=utf-8' -u $LOGIN -d $'{"_edgeType": "dependsOn","_fromUniqueId": "catalogue-db-id","_toUniqueId": "mongodb-id"}'
echo "."




