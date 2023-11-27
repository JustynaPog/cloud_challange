provider "google" {
  
  project     = "poised-runner-401416"
  region      = "us-central1"
  zone    = "us-central1-c"
}

resource "google_storage_bucket" "terra_bucket" {
  name          = "dareit-terra"
  location      = "US"  
  force_destroy = true   

  versioning {
    enabled = true
  }

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  uniform_bucket_level_access = false
}

resource "google_storage_default_object_access_control" "example_bucket_public" {
  bucket       = google_storage_bucket.terra_bucket.name
  entity       = "allUsers"
  role         = "READER"
}

resource "google_compute_instance" "dare-it-vm" {
  name         = "dareit-vm-tf"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        managed_by_terraform = "true"
      }
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}


 
resource "google_sql_database_instance" "justana" {
  name             = "my-justyna-instance"
  database_version = "POSTGRES_14"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = "true"
}
resource "google_sql_database" "dareme" {
  name     = "dareit"
  instance = google_sql_database_instance.justana.name
}

resource "google_sql_user" "Koralik" {
  name     = "dareit_user"
  instance = google_sql_database_instance.justana.name
  password = "terra"  

}