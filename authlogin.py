import subprocess
import argparse
import os

def login_gcloud():
    # Run gcloud auth application-default login command
    result = subprocess.run(["gcloud", "auth", "application-default", "login", "--no-launch-browser"], capture_output=True, text=True)

    # Check if the command succeeded
    if result.returncode == 0:
        # Extract the authorization code from the command output
        output = result.stdout.strip()
        authorization_code = output.split(" ")[-1]

        # Print the authorization code
        print("Authorization Code:", authorization_code)
    else:
        # Print the error message if the command failed
        print("Error:", result.stderr)

if __name__ == "__main__":
    login_gcloud()

def terraform():
    parser = argparse.ArgumentParser(description="GCP Terraform Deployment Script")
    parser.add_argument("project_id", type=str, help="Project ID")
    parser.add_argument("location", type=str, help="Location")
    parser.add_argument("github_repository", type=str, help="GitHub repository")

    args = parser.parse_args()

    project_id = args.project_id
    location = args.location
    github_repository = args.github_repository

    # Set project with gcloud config command
    subprocess.run(["gcloud", "config", "set", "project", project_id], check=True)


    os.chdir("oidc-simple")

    # Run terraform init
    subprocess.run(["terraform", "init"], check=True)

    # Run terraform apply with variable values
    subprocess.run(["terraform", "apply", "-auto-approve",
        "-var", f"project_id={project_id}",
        "-var", f"location={location}",
        "-var", f"github_repository={github_repository}",
    ], check=True)

if __name__ == "__main__":
    terraform()