![CI](https://github.com/nearform/hub-template/actions/workflows/ci.yml/badge.svg?event=push)

# Hub Template

A feature-packed template to start a new repository on the hub, including:

- code linting with [ESlint](https://eslint.org) and [prettier](https://prettier.io)
- pre-commit code linting and commit message linting with [husky](https://www.npmjs.com/package/husky) and [commitlint](https://commitlint.js.org/)
- dependabot setup with automatic merging thanks to ["merge dependabot" GitHub action](https://github.com/fastify/github-action-merge-dependabot)
- notifications about commits waiting to be released thanks to ["notify release" GitHub action](https://github.com/nearform/github-action-notify-release)
- PRs' linked issues check with ["check linked issues" GitHub action](https://github.com/nearform/github-action-check-linked-issues)
- Continuous Integration GitHub workflow


# OIDC Simple Example

## Overview

This example showcases how to configure [Workload Identity Federation](https://cloud.google.com/iam/docs/workload-identity-federation) using the [gh-oidc module](modules/gh-oidc/README.md) for a sample Service Account.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs
Based on ### [Imputs](oidc-simple/variables.tf) 

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The project id to create WIF pool and  SA | `string` | n/a | yes |
| github\_repository | Place where is based the application on gituhub that going to use this serviceaccount eg: neaform/github-gcp-automation | `string` | n/a | yes |
| credential | Location where is going to be created | `json format` | n/a | yes |

 <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements
- You must have installed the gcloud cli to login on gcloud [gcloud cli](https://cloud.google.com/sdk/docs/instal)
- Your gcp account must have permission to create service account in the target gcp project.

## Usage

There are 3 different way to use the oidc simple module:

**1- Through GitHub Actions (https://github.com/nearform/github-gcp-automation/actions/workflows/gcpauth.yml)**
- Run `gcloud auth application-default login` to log in into the target GCP project. This step will create the application default credentials file
  that you will use to provide the correct credential to run the action. The file location is displayed in console after the login is completed successfully
  ![Credential local](/imgs/credentials-auth.jpg "Windows example")
- Go to path informed, open the json and copy all this information to be used into `credentials` (TO BE REVIEWED/UPDATED)
    ![Inputs workflow](/imgs/inputs-credential.jpg "Input example")
- The workflow will create the required SA and the WorkloadIdentityPool. The relevant info will be found in the "run terraform" output in the action logs.
    ![Output](/imgs/outputs.jpg "Output example")

2- Clone this repo and run the terraform module directly or using the authlogin.py script. In both the cases you will need to log in the gcloud cli
     with the correct credentials to perform the SA and WorkloadIdentityPool creation on the GCP target project.

3- Consuming terraform modules from other project that are using terraform


## Outputs

| Name | Description |
|------|-------------|
| pool\_name | Pool name |
| provider\_name | Provider name |
| sa\_email | Example SA email |

- Grab the Outputs and save into bitwarden (this information going to be used as variables Github Actions to authentication)

For more details ### [OIDC details](modules/gh-oidc/README.md)


# Possible errors:
- Wrong inputs
- Missing necessary permission for user is running the terraform (should be owner of the project)

