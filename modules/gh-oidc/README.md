## GitHub OIDC

This module handles the opinionated creation of infrastructure necessary to configure [Workload Identity pools](https://cloud.google.com/iam/docs/workload-identity-federation#pools) and [providers](https://cloud.google.com/iam/docs/workload-identity-federation#providers) for authenticating to GCP using GitHub Actions OIDC tokens.

This includes:

- Creation of a Workload Identity pool
- Configuring a Workload Identity provider
- Granting external identities necessary IAM roles on Service Accounts
- Enabling apis:
  - *artifactregistry.googleapis.com;*
  - *cloudresourcemanager.googleapis.com;*
  - *iamcredentials.googleapis.com;*
  - *sts.googleapis.com;*
  - *secretmanager.googleapis.com;*
  - *iam.googleapis.com;*
  - *serviceusage.googleapis.com;*
  - *container.googleapis.com;*
  - *storage-api.googleapis.com;*
### Example Usage

Based on .\oidc-simple\variables.tf

```terraform
variable "project_id" {
  type        = string
  description = "The project id to create WIF pool and example SA"
  default = "[]"
}

variable "location" {
  type        = string
  default = "[]" # fill with location
}

variable "github_repository" {
  type        = string
  description = "organization / repository"
  default     = "[]" # fill with github information where is based the application on gituhub going to use this serviceaccount eg: neaform/github-gcp-automation
}
```

Below are some examples:

This example shows how to use this module along with a Service Account to deploy a cloud run service on GCP.

### GitHub Workflow

Once provisioned, you can use the [google-github-actions/auth](https://github.com/google-github-actions/auth) Action in a workflow as shown below

```yaml
# Example workflow
# .github/workflows/cd.yml

name: CD

on: 
  push:
   branches:
    - master
  workflow_dispatch:

permissions:
  contents: 'read'
  id-token: 'write'

jobs:
  deploy:
    runs-on: ubuntu-latest

    environment:
      name: production
      url: ${{ steps.deploy.outputs.url }}

    steps:
      - uses: 'actions/checkout@v3'

      - id: 'auth'
        uses: 'google-github-actions/auth@v1'
        with:
          workload_identity_provider: ${{ vars.WORKLOAD_IDENTITY_PROVIDER }} # this is the output provider_name from the TF module
          service_account: ${{ vars.SERVICE_ACCOUNT }} # this is the output provider_name from the TF module
          project_id: ${{ vars.PROJECT_ID }}
          token_format: 'access_token'

      - uses: nearform-actions/github-action-gcp-secrets@v1
        with:
          secrets: |-
            OAUTH_CLIENT_SECRET:"${{ secrets.OAUTH_CLIENT_SECRET }}"
            OAUTH_CLIENT_ID:"${{ secrets.OAUTH_CLIENT_ID }}"

      - id: deploy
        uses: google-github-actions/deploy-cloudrun@v1
        with:
          service: github-dashboard
          region: us-central1
          env_vars: |
            CALLBACK_URL=${{ vars.CALLBACK_URL }}
            AUTH_REDIRECT_URL=${{ vars.AUTH_REDIRECT_URL }}
            CLIENT_AUTH_REDIRECT_URL=${{ vars.CLIENT_AUTH_REDIRECT_URL }}
          secrets: |
            OAUTH_CLIENT_ID=OAUTH_CLIENT_ID:latest
            OAUTH_CLIENT_SECRET=OAUTH_CLIENT_SECRET:latest
          flags: --allow-unauthenticated
          source: .
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_audiences | Workload Identity Pool Provider allowed audiences. | `list(string)` | `[]` | no |
| attribute\_condition | Workload Identity Pool Provider attribute condition expression. [More info](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider#attribute_condition) | `string` | `null` | no |
| attribute\_mapping | Workload Identity Pool Provider attribute mapping. [More info](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider#attribute_mapping) | `map(any)` | <pre>{<br>  "attribute.actor": "assertion.actor",<br>  "attribute.aud": "assertion.aud",<br>  "attribute.repository": "assertion.repository",<br>  "google.subject": "assertion.sub"<br>}</pre> | no |
| issuer\_uri | Workload Identity Pool Issuer URL | `string` | `"https://token.actions.githubusercontent.com"` | no |
| pool\_description | Workload Identity Pool description | `string` | `"Workload Identity Pool managed by Terraform"` | no |
| pool\_display\_name | Workload Identity Pool display name | `string` | `null` | no |
| pool\_id | Workload Identity Pool ID | `string` | n/a | yes |
| project\_id | The project id to create Workload Identity Pool | `string` | n/a | yes |
| provider\_description | Workload Identity Pool Provider description | `string` | `"Workload Identity Pool Provider managed by Terraform"` | no |
| provider\_display\_name | Workload Identity Pool Provider display name | `string` | `null` | no |
| provider\_id | Workload Identity Pool Provider id | `string` | n/a | yes |
| sa\_mapping | Service Account resource names and corresponding WIF provider attributes. If attribute is set to `*` all identities in the pool are granted access to SAs. | <pre>map(object({<br>    sa_name   = string<br>    attribute = string<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| pool\_name | Pool name |
| provider\_name | Provider name |

 <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

Before this module can be used on a project, you must ensure that the following pre-requisites are fulfilled:

1. Project on GCP created, going to be necessary the project id

2. Owner permisison for the user going to be execute the terraform
