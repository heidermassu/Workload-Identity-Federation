from google.auth import default, exceptions
from google.auth.transport import requests
import subprocess
import argparse

def login_to_gcp():
    try:
        credentials, project_id = default()
    except exceptions.DefaultCredentialsError:
        print("Unable to retrieve default credentials. Please make sure you have authenticated with gcloud.")
        return

    if credentials.expired:
        try:
            credentials.refresh(requests.Request())
        except exceptions.RefreshError:
            print("Failed to refresh credentials. Please check your authentication configuration.")
            return

    # Access token for authentication
    access_token = credentials.token

    # Print the access token (for demonstration purposes)
    print(f"Access token: {access_token}")

    # Use the credentials for further API requests or operations



def terraform():
    parser = argparse.ArgumentParser(description="GCP Terraform Deployment Script")
    parser.add_argument("project_id", type=str, help="Project ID")
    parser.add_argument("location", type=str, help="Location")
    parser.add_argument("github_repository", type=str, help="GitHub repository")

    args = parser.parse_args()

    project_id = args.project_id
    location = args.location
    github_repository = args.github_repository
    # Change to the oidc-simple folder
    subprocess.run(["cd", ".\\oidc-simple"], shell=True, check=True)

    # Run terraform init
    subprocess.run(["terraform", "init"], cwd=".\\oidc-simple", check=True)

    # Run terraform apply with variable values
    #subprocess.run(["terraform", "apply", f"-var=project_id={project_id}", f"-var=location={location}", f"-var=github_repository={github_repository}"], cwd=".\\oidc-simple", check=True)
    subprocess.run(["terraform", "apply",
            "-var",
            f"project_id={project_id}",
            "-var",
            f"location={location}",
            "-var",
            f"github_repository={github_repository}",
        ],
        cwd=".\\oidc-simple",
        check=True,
    )
if __name__ == "__main__":
    login_to_gcp(),
    terraform()