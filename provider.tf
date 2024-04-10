terraform {
backend "gcs" {
    bucket  = "roidtc-240408-user504-tf-state"
    prefix  = "terraform/state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.2.0"
    }
  }

}


provider "google" {

  project = var.project_id

}
