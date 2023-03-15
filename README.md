# Deploying-Microservices-on-Azure-Kubernetes-Engine-with-Istio-as-a-Sidecar-Container
**Step 1: Install Terraform on your local machine depending upon your machine by following the instructions provided on the Terraform website.**

**Step 2: Configure Azure credentials: Set up Azure credentials to allow Terraform to authenticate with Azure.**

Install Azure CLI on your local machine. Check the documentation link.

Open the Azure CLI command prompt and log in to your Azure account using the following cmd:

```
az login
```

**Step 3: Create a Terraform project**

Create a new directory for your Terraform project and initialize it with the following cmd:

```terraform init```

**Step 4: Create an AKS Cluster**

Now deploy the file “main.tf “ which is given in the Github repository in which we have configured an AKS cluster with three nodes, Linux-based VMs, and a service principal to authenticate with Azure. (Replace the credentials where mentioned).
Run this cmd in the same directory.

```terraform apply main.tf```

**Step 5: Check that nodes are provisioned as stated in the terraform configuration by following the cmd**

```kubectl get nodes```

**Step 6: Check that nodes are available by following the cmd**

```kubectl get nodes```

**Step 7: Install Istio After creating the AKS cluster, install Istio using the Terraform Kubernetes provider by using istio.tf file which is in the repo.**

```terraform apply istio.tf```

**Step 8: Check Istio is running by following the cmd**

```kubectl get pods -n istio-system```

**Step 9: Before deploying the microservices, it is better to configure Istio for automatic envoy proxy injection by running this cmd**

```kubectl label namespace default istio-injection=enabled```

**Step 10: Now, deploy a demo microservice application to the AKS cluster( manifest file present in the repo with the named “kubernetes-manifests”) by applying the following cmd.**

```kubectl apply -f kubernetes-manifests.yaml```

Note: Wait for more than 10 minutes so that all the microservices are in a running state.

**Step 11: Check all the microservices are running by following cmd**

```kubectl get pods```

*Important Note: Now you should see each service has two pods running, one as an application and another as a sidecar container running service mesh(Istio).*

# To set up Grafana and Prometheus in Istio to monitor and visualize the microservices, you need to follow these steps:

**Step 12: Install the Prometheus add-on for Istio by running the following cmd:**

```kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.11/samples/addons/prometheus.yaml```

**Step 13: Install Grafana by running the following cmd:**

```kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.11/samples/addons/grafana.yaml```

**Step 14: Create a Gateway and VirtualService to expose the Grafana service outside the cluster. You can use the YAML manifest file named “grafana.yaml”:**

```kubectl apply -f grafana.yaml```

This will create a Gateway and VirtualService that exposes Grafana on port 80 of the Istio ingress gateway.

**Step 15: Access Grafana by opening a web browser and navigating to the URL of the Istio ingress gateway.**

This URL should be in the format http://<istio-ingress-gateway-ip>/.

**Step 16: You can find the IP address of the Istio ingress gateway using the following command:**

```kubectl get svc istio-ingressgateway -n istio-system```

Once you access Grafana, you can create dashboards to visualize the metrics collected by Prometheus from Istio. You can use Istio’s built-in dashboards or create your own custom dashboards.

**Step 17: To delete all the resources, you can use the following cmds**

```
kubectl delete -f kubernetes-manifests.yaml

terraform destroy -target module.istio

terraform destroy -target module.aks

az group delete --name my-aks-rg --yes --no-wait
```
