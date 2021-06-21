provider "aws" {
  region = var.region
}

module "kms_key" {
  source = "../../"

  description             = "Test KMS key"
  deletion_window_in_days = 7
  enable_key_rotation     = false
  alias = "testkeyjja"
  tags = {
    ntt_monitoring  = "1"
    ntt_owner       = "Juanje"
  }

}
