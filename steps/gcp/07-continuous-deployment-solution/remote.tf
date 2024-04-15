terraform {
  backend "gcs" {
    bucket = "sfeir-school-terraform-backends"
    prefix = "trainer"
  }
}
