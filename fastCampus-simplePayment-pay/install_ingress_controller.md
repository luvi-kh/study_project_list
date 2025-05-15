## AWS Load Balancer Ingress Controller 설치 
- Terraform 기반으로 K8S Cluster를 실행 후에 설치 진행
```
# Kubeconfig 설정
aws eks --region ap-northeast-2 update-kubeconfig --name k8s-demo

# K8S Cluster 연결 확인 
kubectl get no

# Helm charts repo 추가 
helm repo add eks https://aws.github.io/eks-charts

# AWS Load Balancer Ingress Controller 설치 
# !! 590974975982 부분은 본인 AWS 계정으로 변경
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system --set clusterName=k8s-demo --set serviceAccount.create=true \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set serviceAccount.annotations."eks\.amazonaws\.com/role-arn"="arn:aws:iam::590974975982:role/load-balancer-controller"
```
