

resource "aws_kms_key" "eks" {
  description             = "EKS Secret Key"
  deletion_window_in_days = 7
  enable_key_rotation     = true

}



