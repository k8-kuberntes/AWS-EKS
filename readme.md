Create a kubeconfig file for manging the EKS Cluster.

Login to your kubectl node and insert the codeblock to .kube/config

apiVersion: v1
clusters:
- cluster:
    server: EKS_ENDPOINT_URL
    certificate-authority-data: BASE64_ENCODED_CA_CERT   
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: heptio-authenticator-aws
      args:
        - "token"
        - "-i"
        - "CLUSTER_NAME"
        - "-r"
        - ""
Replace EKS_ENDPOINT_URL with your EKS Endpoint URL, BASE64_ENCODED_CA_CERT with certificateAuthority and CLUSTER_NAME with EKS Cluster name.

Save the configuration file and execute following commands to use it.

export KUBECONFIG=$KUBECONFIG:~/.kube/config

echo 'export KUBECONFIG=$KUBECONFIG:~/.kube/config' >> ~/.bashrc
Now test your configuration

kubectl get all
