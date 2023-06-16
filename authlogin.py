import subprocess
import argparse
import os

def terraform():
    parser = argparse.ArgumentParser(description="GCP Terraform Deployment Script")
    parser.add_argument("project_id", type=str, help="Project ID")
    parser.add_argument("location", type=str, help="Location")
    parser.add_argument("github_repository", type=str, help="GitHub repository")

    args = parser.parse_args()

    project_id = args.project_id
    location = args.location
    github_repository = args.github_repository

    os.chdir("oidc-simple")

    # Run terraform init
    subprocess.run(["terraform", "init"], check=True)

    # Run terraform apply with variable values
    subprocess.run(["terraform", "apply",
        "-var", f"project_id={project_id}",
        "-var", f"location={location}",
        "-var", f"github_repository={github_repository}",
    ], check=True)

if __name__ == "__main__":
    terraform()