import subprocess
from google.auth import default, exceptions
from google.auth.transport import requests

# Prompt the user for variable values
#project_id = input("Enter the project ID: ")
#location = input("Enter the location: ")
#github_repository = input("Enter the GitHub repository: ")


# Try to get the default credentials
try:
    credentials, project_id = default()
except exceptions.DefaultCredentialsError:
    print("Unable to retrieve default credentials. Please make sure you have authenticated with gcloud.")
    exit(1)

# Check if the credentials need to be refreshed
if credentials.expired:
    try:
        credentials.refresh(requests.Request())
    except exceptions.RefreshError:
        print("Failed to refresh credentials. Please check your authentication configuration.")
        exit(1)

# Get the access token
access_token = credentials.token

# Print the access token (for demonstration purposes)
print(f"Access token: {access_token}")
print(f"project_id: {project_id}")
print(f"location: {location}")
print(f"github_repository: {github_repository}")

# Change to the oidc-simple folder
subprocess.run(["cd", ".\\oidc-simple"], shell=True, check=True)

# Run terraform init
subprocess.run(["terraform", "init"], cwd=".\\oidc-simple", check=True)

# Run terraform plan
subprocess.run(["terraform", "plan"], cwd=".\\oidc-simple", check=True)

# Run terraform apply with variable values
#subprocess.run(["terraform", "apply", f"-var=project_id={project_id}", f"-var=location={location}", f"-var=github_repository={github_repository}"], cwd=".\\oidc-simple", check=True)
subprocess.run(["terraform", "apply", "-var","project_id={project_id}", "-var","location={location}","-var","github_repository={github_repository}", ],cwd=".\\oidc-simple", check=True,)
