~/.launch.sh
until $(oc get project istio-system &> /dev/null); do sleep 1; done
export PATH=$PATH:/root/installation/istio-0.7.1/bin/
