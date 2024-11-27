terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.12.0"
    }
  }
  cloud {
    organization = "Shree-Devops"
    workspaces {
      name = "gcp-vm-workspace"
    }
  }
}

provider "google" {
  project     = "bold-cable-442407-c1"
  region      = "us-central1"
  zone        = "us-central1-c"
  credentials = jsondecode(var.Google_key)
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-vm"
  machine_type = "n1-standard-1"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {
      # Ephemeral public IP
    }
  }
}

variable "Google_key" {}
variable "zone" {
  default = "us-central1-c"
}
