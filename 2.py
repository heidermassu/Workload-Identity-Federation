from google.auth import client_secrets, exceptions
from google.auth.transport import requests
import subprocess
import argparse
from google_auth_oauthlib.flow import InstalledAppFlow

def login_to_gcp(username, password):
    flow = InstalledAppFlow.from_client_secrets_file("client_secrets.json", scopes=["https://www.googleapis.com/auth/cloud-platform"])
    credentials = flow.run_local_server(port=0)

    # Access token for authentication
    access_token = credentials.token

    # Print the access token (for demonstration purposes)
    print(f"Access token: {access_token}")

    # Use the credentials for further API requests or operations

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="GCP Terraform Deployment Script")
    parser.add_argument("username", type=str, help="GCP username")
    parser.add_argument("password", type=str, help="GCP password")
    parser.add_argument("project_id", type=str, help="Project ID")
    parser.add_argument("location", type=str, help="Location")
    parser.add_argument("github_repository", type=str, help="GitHub repository")

    args = parser.parse_args()

    username = args.username
    password = args.password
    project_id = args.project_id
    location = args.location
    github_repository = args.github_repository

    login_to_gcp(username, password)

    # Change to the oidc-simple folder
    subprocess.run(["cd", ".\\oidc-simple"], shell=True, check=True)

    # Run terraform init
    subprocess.run(["terraform", "init"], cwd=".\\oidc-simple", check=True)

    # Run terraform apply with variable values
    subprocess.run(
        ["terraform", "apply",
         "-var", f"project_id={project_id}",
         "-var", f"location={location}",
         "-var", f"github_repository={github_repository}"
        ],
        cwd=".\\oidc-simple",
        check=True
    )
