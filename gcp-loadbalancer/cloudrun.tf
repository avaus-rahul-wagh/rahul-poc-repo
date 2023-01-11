# Enable the Cloud Run API
resource "google_project_service" "cloud_run_api" {
  project            = var.project_id
  service            = "run.googleapis.com"
  disable_on_destroy = true
}

# Create a cloud run
resource "google_cloud_run_service" "profile_component_cloud_run_srv" {
  name     = "test-cloudrun-srv"
  location = var.gcp_location
  project  = var.project_id
  depends_on = [
    google_project_service.cloud_run_api
  ]

  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}