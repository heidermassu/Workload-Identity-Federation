resource "google_project_service" "artifact_registry_api" {
  project = var.project_id
  service = "artifactregistry.googleapis.com"
}

resource "google_project_service" "cloudresourcemanager_googleapis_com" {
  project = var.project_id
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "iamcredentials_googleapis_com" {
  project = var.project_id
  service = "iamcredentials.googleapis.com"
}

resource "google_project_service" "sts_googleapis_com" {
  project = var.project_id
  service = "sts.googleapis.com"
}

resource "google_project_service" "secretmanager_googleapis_com" {
  project = var.project_id
  service = "secretmanager.googleapis.com"
}

resource "google_project_service" "iam_googleapis_com" {
  project = var.project_id
  service = "iam.googleapis.com"
}

resource "google_project_service" "serviceusage_googleapis_com" {
  project = var.project_id
  service = "serviceusage.googleapis.com"
}
resource "google_project_service" "container_googleapis_com" {
  project = var.project_id
  service = "container.googleapis.com"
}
resource "google_project_service" "storage_api_googleapis_com" {
  project = var.project_id
  service = "storage-api.googleapis.com"
}