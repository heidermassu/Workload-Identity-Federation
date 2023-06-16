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

provider "google" {
project =  var.project_id
region =  var.location
credentials = "${file("./application_default_credentials.json")}"

}