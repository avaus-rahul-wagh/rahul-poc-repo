terraform {
  backend "gcs" {
    bucket = "poc-bucket-lb"
    prefix = "load-balancer"
  }
}
