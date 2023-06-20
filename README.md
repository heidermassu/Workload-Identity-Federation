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

## pre-requisits
You must have installed the gcloud cli to login on gcloud [gcloud cli](https://cloud.google.com/sdk/docs/instal)
## How to execute
There are 3 differents way can be executed:
**1- Through GitHub Actions (https://github.com/nearform/github-gcp-automation/actions/workflows/gcpauth.yml)**
    - Using any ide which provide oportunity to run `gcloud auth application-default login` will interact with a browser to inform your user and password to connect into GCP. Even though you choose to run through Github Action this step is important to generate the imputs that going to be prompt in the GitHub Actions.
    - After login will be informed in the ide where your `application_default_credentials.json` where created or updated.
    ![Credential local](/imgs/credentials-auth.jpg "Windows example")
    - Go to path informed, open the json and copy all this information to be used into `credentials`
    ![Inputs workflow](/imgs/inputs-credential.jpg "Input example")
    - After start the workflow the GitHub Actions going to create the service account in the project mentioned with Workload Identity Federation (OIDC) for the repository also mentioned using your user were informed. in the end of execution will have a output with the information needed to use OIDC:
    ![Output](/imgs/outputs.jpg "Output example")
2- Donwloading repository and run terraform or python locally
3- consuming terraform modules from other project that are using terraform


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

