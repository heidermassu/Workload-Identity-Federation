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
| location | Location where is going to be created | `string` | n/a | yes |
| github\_repository | Place where is based the application on gituhub that going to use this serviceaccount eg: neaform/github-gcp-automation | `string` | n/a | yes |

 <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


# How to execute
- Need to be logged into gcp (***gcloud auth login*** and ***gcloud auth application-default login***)
- Go to folder **.\oidc-simple** run ***terraform init***
- ***terraform plan***
- ***terraform apply -var="project_id=final-test-389819" -var="location=us-central1" -var="github_repository=heidermassu/gcp-test"**
## Outputs

| Name | Description |
|------|-------------|
| pool\_name | Pool name |
| provider\_name | Provider name |
| sa\_email | Example SA email |

- grab the Outputs and save into bitwarden (this information going to be used as variables Github Actions to authentication)

For more details ### [OIDC details](modules/gh-oidc/README.md)

NEcessary:
pip install google-auth google-auth-oauthlib
Note that this script assumes that you have the necessary tools (gcloud and terraform) installed and configured in your environment. Also, make sure to update the path to the oidc-simple folder if it's located elsewhere.
# Possible errors:
- wrong imputs
- Missing necessary permission for user is running the terraform (should be owner of the project)

