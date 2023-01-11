# [START cloudloadbalancing_ext_http_cloudrun]
module "lb-http" {
  source  = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version = "~> 6.3"
  name    = var.lb_name
  project = var.project_id

  ssl = var.ssl
  #managed_ssl_certificate_domains = [var.domain]
  https_redirect = var.ssl
  labels         = { "example-label" = "cloud-run-example" }

  backends = {
    default = {
      description = null
      groups = [
        {
          group = google_compute_region_network_endpoint_group.serverless_neg.id
        }
      ]
      enable_cdn              = false
      security_policy         = null
      custom_request_headers  = null
      custom_response_headers = null

      iap_config = {
        enable               = false
        oauth2_client_id     = ""
        oauth2_client_secret = ""
      }
      log_config = {
        enable      = false
        sample_rate = null
      }
    }
  }
}

# Enable the Cloud Run API
resource "google_project_service" "compute_engine_api" {
  project            = var.project_id
  service            = "compute.googleapis.com"
  disable_on_destroy = true
}

resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  provider              = google-beta
  name                  = "serverless-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.gcp_region
  project               = var.project_id
  depends_on = [
    google_project_service.compute_engine_api
  ]
  cloud_run {
    service = google_cloud_run_service.profile_component_cloud_run_srv.name
  }
}

resource "google_cloud_run_service_iam_member" "public-access" {
  location = google_cloud_run_service.profile_component_cloud_run_srv.location
  project  = google_cloud_run_service.profile_component_cloud_run_srv.project
  service  = google_cloud_run_service.profile_component_cloud_run_srv.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
