variable "project_id" {
  type        = string
  description = "The project id to create WIF pool and example SA"
  default = "wif-test-389720"
}

variable "location" {
  type        = string
  description = "..."
  default = "us-central1"
}

variable "github_repository" {
  type        = string
  default     = "heidermassu/wif-test"
}


