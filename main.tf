
provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "terraform_state_bucket" {
  name          = "state-bucket-nour-personal-bucket-tfstate"
  force_destroy = true
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
  # encryption {
  #   default_kms_key_name = google_kms_crypto_key.terraform_state_bucket.id
  # }
  # depends_on = [
  #   google_project_iam_member.default
  # ]
}

terraform {
  backend "gcs" {
    bucket = "state-bucket-nour-personal-bucket-tfstate"
    prefix = "terraform/state"
  }
}

module "kms" {
  source = "./kms"
  project_id = var.project_id
}