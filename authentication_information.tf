terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">=7.10.0"
    }
  }
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  region           = var.region
  user_ocid        = var.user_ocid
  private_key_path = "${path.module}/keys/${var.api_key_name}.pem"
  fingerprint      = var.api_key_fingerprint
}