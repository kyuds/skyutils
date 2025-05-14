#!/bin/zsh

if [ -z "$1" ]; then
    echo "Usage: $0 <command>"
    exit 1
fi

NAMESPACE=skypilot
RELEASE_NAME=skypilot
WEB_USERNAME=skypilot
WEB_PASSWORD=temp123
AUTH_STRING=$(htpasswd -nb $WEB_USERNAME $WEB_PASSWORD)

case "$1" in
    setup)
        helm repo add skypilot https://helm.skypilot.co
        helm repo update
        helm upgrade --install $RELEASE_NAME skypilot/skypilot-nightly --devel \
            --namespace $NAMESPACE \
            --create-namespace \
            --set ingress.authCredentials=$AUTH_STRING
        ;;
    status)
        kubectl get pods --namespace $NAMESPACE -l app=${RELEASE_NAME}-api --watch
        ;;
    status-log)
        kubectl describe pod -n $NAMESPACE -l app=${RELEASE_NAME}-api
        ;;
    url)
        HOST=$(kubectl get svc ${RELEASE_NAME}-ingress-nginx-controller --namespace $NAMESPACE -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
        ENDPOINT=http://${WEB_USERNAME}:${WEB_PASSWORD}@${HOST}
        echo $ENDPOINT
        ;;
    uninstall)
        helm uninstall $RELEASE_NAME --namespace $NAMESPACE
        ;;
    *)
        echo "Unknown command: $1"
        echo "Available commands: setup, status, status-log, url, uninstall"
        exit 1
        ;;
esac
