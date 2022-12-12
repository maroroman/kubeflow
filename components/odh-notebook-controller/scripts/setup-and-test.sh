mkdir -p ~/.kube
cp /tmp/kubeconfig ~/.kube/config 2> /dev/null || cp /var/run/secrets/ci.openshift.io/multi-stage/kubeconfig ~/.kube/config
chmod 644 ~/.kube/config
export KUBECONFIG=~/.kube/config

ODHPROJECT=${ODHPROJECT:-"opendatahub"}
export ODHPROJECT

echo "OCP version info"
echo `oc version`

if [ -z "${SKIP_INSTALL}" ]; then
    # This is needed to avoid `oc status` failing inside openshift-ci
    oc new-project ${ODHPROJECT}
    ./install.sh
    echo "Sleeping for 5 min to let the KfDef install settle"
    sleep 5m
fi


cd ..
make e2e-test