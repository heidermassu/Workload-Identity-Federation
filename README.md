# Workload-Identity-Federation
1- Need to be logged into gcp (***gcloud auth login*** and ***gcloud auth application-default login***)
2- Go to **.\oidc-simple** run ***terraform init***
3- ***terraform plan***
4- ***terraform apply***
5- grab the outcome and save into bitwarden (this information going to be used as variables Github Actions to authentication)


possible errors:
- wrong project id
- Not necessary permission for user is running the terraform (should be owner of the project)

