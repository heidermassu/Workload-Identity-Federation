resource "google_iam_workload_identity_pool" "main" {
  #provider                  = google-beta
  project                   = var.project_id
  workload_identity_pool_id = var.pool_id
  display_name              = var.pool_display_name
  description               = var.pool_description
  disabled                  = false
  #location                  = "global"
}
#
resource "google_iam_workload_identity_pool_provider" "main" {
  #provider                           = google-beta
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.main.workload_identity_pool_id
  workload_identity_pool_provider_id = var.provider_id
  display_name                       = var.provider_display_name
  description                        = var.provider_description
  attribute_condition                = var.attribute_condition
  attribute_mapping                  = var.attribute_mapping
  #location                  = "global"
  oidc {
    allowed_audiences = var.allowed_audiences
    issuer_uri        = var.issuer_uri
  }
}

#resource "google_iam_workforce_pool" "pool" {
#  workforce_pool_id = var.pool_id
#  parent            = "organizations/813738584427"
#  location          = "global"
#}

#resource "google_iam_workforce_pool_provider" "provider" {
#  workforce_pool_id  = google_iam_workload_identity_pool.main.workforce_pool_id
#  location           = google_iam_workload_identity_pool.main.location
#  provider_id        = var.provider_id
#  attribute_mapping  = var.attribute_mapping
#  oidc {
#    issuer_uri       = "https://token.actions.githubusercontent.com"
#    client_id        = "client-id"
#    web_sso_config {
#      response_type             = "ID_TOKEN"
#      assertion_claims_behavior = "ONLY_ID_TOKEN_CLAIMS"
#    }
#  }
#  }
#

resource "google_service_account_iam_member" "wif-sa" {
  for_each           = var.sa_mapping
  service_account_id = each.value.sa_name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.main.name}/${each.value.attribute}"
}

