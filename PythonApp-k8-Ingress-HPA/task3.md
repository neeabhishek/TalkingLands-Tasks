Scenario:
Deploy a sample Python application on a Kubernetes cluster with auto-scaling
enabled.

Requirements:
1. Write Kubernetes manifests for:
 * A Deployment with at least 2 replicas.
 * A Service to expose the application.
 * An Ingress to route HTTP traffic.
2. Configure a HorizontalPodAutoscaler to scale based on CPU usage.

Prerequisites:
1. Minikube is being utilized for the setup; as a Prerequisites ingress addon needs to be installed  using the command - minikube addons enable ingress. This helps us in deploying Ingress controller.
2. Metrics-server addon needs to be installed for HPA (HorizontalPodAutoscaler).
2. URL for accessing the Python app - http://192.168.49.2.nip.io/talking-lands-task
3. Here we are giving the minikube ip as the host in ingress definition file with nip.io as the dynamic DNS (free) to avoid writes in /etc/hosts. This will enable the ingress to correctly route the request to the python-webapp-svc and then to the python-webapp.

K8 Doc:
1.https://kubernetes.io/docs/concepts/services-networking/ingress/#resource-backend
2.https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/
3.https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/