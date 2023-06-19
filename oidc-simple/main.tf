module "oidc" {
  source      = "../modules/gh-oidc"
  project_id  = var.project_id
  pool_id     = "pool-test-${var.project_id}"
  provider_id = "provider-test-${var.project_id}"
  sa_mapping = {
    (google_service_account.sa.account_id) = {
      sa_name   = google_service_account.sa.name
      attribute = "attribute.repository/${var.github_repository}"
    }
  }
}

module "apis" {
  source      = "../modules/gh-apis"
  project_id  = var.project_id
  
}

module "svc" {
  source      = "../modules/gh-serviceaccount"
  project_id  = var.project_id
  
}

#module "project" {
#  source      = "../modules/gh-project"
#  project_id  = var.project_id
#  organization_id = "heidermassu"
#  billing_account_id =  "01A8D3-F5F4E8-04617A"
#  project_name = var.project_id
#}
