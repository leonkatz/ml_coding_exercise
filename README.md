# ml_coding_exercise

### AWS Setup
- Setup "default" profile in .aws/config, .aws/credentials

### Github Repo
- Fork Github Repo
```
git@github.com:leonkatz/ml_coding_exercise.git
```
### Setup The following Github Secrets
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY

### Run Github Actions
- setup_terraform_backend
- deploy_infrastructure

## Record Output from deploy_infrastructure_job 

### Add more github secrets and variables
#### Secrets
- EC2_SSH_KEY
#### Variables
- EC_IP

### Run Gihub Action
- create_db

### Next Steps
- Create Dockerfile to run python etl.py script
  - Install python, pip
  - install python dependencies with pip
  - copy script
  - run script
- Create Github Action to ssh to EC2 instance Build Dockerfile and run Dockerfile
  - Add Github Variables for Postgres host, user, password and DB, and pass as env to Docker.

## Other ways to do this.
- Use AWS Glue
- Run in Kubernetes if cluster already exists.