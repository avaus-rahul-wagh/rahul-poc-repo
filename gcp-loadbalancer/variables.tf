variable "project_id" {
  type        = string
  description = "The project ID"
}
variable "gcp_location" {
  type        = string
  description = "gcloud location"
}
variable "lb_name" {
  description = "Name for load balancer and associated resources"
}
variable "ssl" {
  description = "Run load balancer on HTTPS and provision managed certificate with provided `domain`."
  type        = bool
  default     = true
}
variable "domain" {
  description = "Domain name to run the load balancer on. Used if `ssl` is `true`."
  type        = string
}
variable "gcp_region" {
  description = "Location for load balancer and Cloud Run resources"
  default     = "us-central1"
}