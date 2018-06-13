#!/bin/bash
ssh root@host01 "wget -c https://github.com/istio/istio/releases/download/0.7.1/istio-0.7.1-linux.tar.gz -P /root/installation"

#ssh root@host01 "git --work-tree=/root/projects/istio-tutorial/ --git-dir=/root/projects/istio-tutorial/.git pull"
#ssh root@host01 "rm -rf /root/projects/rhoar-getting-started /root/temp-pom.xml"

ssh root@host01 "tar -zxvf /root/installation/istio-0.7.1-linux.tar.gz -C /root/installation"

ssh root@host01 "sleep 10; oc login -u system:admin; oc adm policy add-cluster-role-to-user cluster-admin admin"

ssh root@host01 "oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account -n istio-system"
ssh root@host01 "oc adm policy add-scc-to-user anyuid -z default -n istio-system"

ssh root@host01 "oc apply -f /root/installation/istio-0.7.1/install/kubernetes/istio.yaml"
ssh root@host01 "oc expose svc istio-ingress -n istio-system"

# Install Prometheus add-on
ssh root@host01 "oc adm policy add-scc-to-user anyuid -z prometheus -n istio-system"
ssh root@host01 "oc apply -f /root/installation/istio-0.7.1/install/kubernetes/addons/prometheus.yaml -n istio-system"
ssh root@host01 "oc expose svc prometheus -n istio-system"

# Install Grafana add-on
ssh root@host01 "oc adm policy add-scc-to-user anyuid -z grafana -n istio-system"
ssh root@host01 "oc apply -f /root/installation/istio-0.7.1/install/kubernetes/addons/grafana.yaml -n istio-system"
ssh root@host01 "oc expose svc grafana -n istio-system"

# Install Jaeger
ssh root@host01 "oc apply -f https://raw.githubusercontent.com/jaegertracing/jaeger-kubernetes/master/all-in-one/jaeger-all-in-one-template.yml -n istio-system"
ssh root@host01 "oc expose svc jaeger-query -n istio-system"
