resource "google_project" "new_project" {
  name       = var.project_name
  project_id = var.project_id
  org_id     = var.organization_id
  billing_account = var.billing_account_id
}