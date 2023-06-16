# Using backend config in CLI will override this block
#terraform {
#  backend "gcs" {
#    bucket = "tfstategcpupskilling"
#    prefix = "statetest"
#  }
#}
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider “google” {
# Configuration options
project = “project-name”
region = “us-east1”
credentials = “${file(“././application_default_credentials.json”)}”

}