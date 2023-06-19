module "oidc" {
  source      = "../modules/gh-oidc"
  project_id  = var.project_id
  pool_id     = "pool-test-test1-${var.project_id}"
  provider_id = "provider-test-test1-${var.project_id}"
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

#module "project" {
#  source      = "../modules/gh-project"
#  project_id  = var.project_id
#  organization_id = "heidermassu"
#  billing_account_id =  "01A8D3-F5F4E8-04617A"
#  project_name = var.project_id
#}

resource "random_string" "name_suffix" {
  length  = 8
  special = false
}

resource "google_service_account" "sa" {
  project    = var.project_id
  account_id = "svc-test-test1-${var.project_id}"
}

resource "google_project_iam_member" "Storage_Admin" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_project_iam_member" "Service_Account_Token_Creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_project_iam_member" "Artifact_Registry_Administrator" {
  project = var.project_id
  role    = "roles/artifactregistry.admin"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_project_iam_member" "Cloud_Build_Service_Account" {
  project = var.project_id
  role    = "roles/cloudbuild.builds.builder"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_project_iam_member" "Artifact_Registry_Reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_project_iam_member" "Cloud_Run_Admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_project_iam_member" "Editor" {
  project = var.project_id
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.sa.email}"
}
resource "google_project_iam_member" "Secret_Manager_Admin" {
  project = var.project_id
  role    = "roles/secretmanager.admin"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_project_iam_member" "Secret_Manager_Secret_Accessor" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_project_iam_member" "Secret_Manager_Viewer" {
  project = var.project_id
  role    = "roles/secretmanager.viewer"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_project_iam_member" "Service_Account_Admin" {
  project = var.project_id
  role    = "roles/iam.serviceAccountAdmin"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_project_iam_member" "Service_Usage_Admin" {
  project = var.project_id
  role    = "roles/serviceusage.serviceUsageAdmin"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_project_iam_binding" "sa_editor" {
  project = var.project_id
  role    =  "roles/editor"
  members = ["serviceAccount:${google_service_account.sa.email}"]
}