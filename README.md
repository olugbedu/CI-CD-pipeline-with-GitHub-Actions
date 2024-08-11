# Deliverables

## 1. Documentations of your processes

#### Step 1: Prepared the Code Repository
- Created a new [repository](https://github.com/olugbedu/CI-CD-pipeline-with-GitHub-Actions) on GitHub and pushed application code.
- Added [application](./main.py) code to the repository. 
- Added a [Dockerfile](./Dockerfile) for the application, to containerize it
- Pushed image to Docker image registry
![docker image](images/dockerhub.png)


#### Step 2: Set Up GitHub Actions
- In the repository, I created a YAML file deploy.yml inside a .github/workflows directory with the required configurations.

`deploy.yml`
```yml
name: CI/CD Pipeline

#trigger events
on:
  push:            
    branches:
      - main      

#job definition
jobs:
  deploy:        
    runs-on: ubuntu-latest  #runner

    steps:
    - name: Checkout Code
      uses: actions/checkout@v4     #action

    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v2

    - name: Log in to DockerHub
      uses: docker/login-action@v2
      with:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}

    - name: Build and Push Docker Image
      run: |
        docker build -t ${{ secrets.DOCKER_USERNAME }}/adedeji-portfolio:latest . 
        docker push ${{ secrets.DOCKER_USERNAME }}/adedeji-portfolio:latest

    - name: SSH into EC2
      uses: appleboy/ssh-action@master
      with:
        host: ${{ secrets.EC2_PUBLIC_IP }}  # data in the repo secret
        username: ubuntu
        key: ${{ secrets.EC2_SSH_KEY }}     # data in the repo secret

    - name: Deploy to Minikube
      run: |
        minikube start
        kubectl apply -f k8S/deployment.yaml 
        kubectl apply -f k8S/service.yaml 
      shell: bash
      continue-on-error: true

    - name: Verify Deployment
      run: |
        kubectl get pods
        kubectl get svc
      shell: bash
      continue-on-error: true
```
#### Step 3: Set Up Terraform for EC2 and Minikube
- Created terraform [modules](./modules/) for your [EC2](./modules/ec2/), [VPC](./modules/vpc/)
- Created [root modules](main.tf)
- Created an EC2 instance with [Minikube](./modules/ec2/scripts/install_minikube.sh) running on it.
- Run the appropriate Terraform commands in your terminal. ![](images/terraform-apply.png)

#### Step 4: Access the Minikube Cluster
- SSH into the created EC2 instance using the public IP output from Terraform. Inside the EC2 instance, I configured kubectl to use the Minikube cluster. I did that by running the `kubectl config use-context minikube` command
    ![ssh client](images/ssh-in.png)
    ![ssh client](images/dockerinstall.png)
    ![ssh client](images/ssh-cli.png)
    ![ssh client](images/minikube-start.png)
    ![ssh client](images/minikube-status.png)

#### Step 5: Automate Deployment with GitHub Actions
- Update the GitHub Actions [workflow](https://github.com/olugbedu/CI-CD-pipeline-with-GitHub-Actions/blob/main/.github/workflows/deploy.yml) to deploy to the Minikube cluster on the EC2 instance. Ensure the Minikube instance's IP and SSH keys are securely managed. 
```yml
 - name: SSH into EC2
      uses: appleboy/ssh-action@master
      with:
        host: ${{ secrets.EC2_PUBLIC_IP }}     # provided in the repository secret
        username: ubuntu
        key: ${{ secrets.EC2_SSH_KEY }}        # provided in the repository secret
```

## 2. Screenshots of your results from each step
GitHub Action
![](images/action6.png)
![](images/action1.png)
![](images/action2.png)
![](images/action3.png)
![](images/action4.png)
![](images/action5.png)


## 3. Application for Deployment
I used Python FastAPI
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Welcome to Adedeji's Portfolio"}

@app.get("/about")
def read_about():
    return {"about": "This is Adedeji's portfolio application."}
```

## 4. Docker image
![](images/dockerhub.png)

## 5. Terraform Modules 
- I created EC2 module [here](./modules/ec2/)
- I created VPC module [here](./modules/vpc/)
- I created Root module [here](main.tf)

## 6. Kubernetes Manifests
- [deployment.yaml](./k8S/deployment.yaml) 
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: adedeji-portfolio
spec:
  replicas: 2
  selector:
    matchLabels:
      app: adedeji-portfolio
  template:
    metadata:
      labels:
        app: adedeji-portfolio
    spec:
      containers:
      - name: adedeji-portfolio
        image: gbedu/adedeji-portfolio:latest
        imagePullPolicy: Always
        ports:
        - containerPort: 80
        resources:
            requests:
                memory: "128Mi"
                cpu: "250m"
            limits:
                memory: "256Mi"
                cpu: "500m"
```

- [service.yaml](./k8S/service.yaml)
```yaml
apiVersion: v1
kind: Service
metadata:
  name: adedeji-portfolio
spec:
  type: ClusterIP
  selector:
    app: adedeji-portfolio
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8000
```







