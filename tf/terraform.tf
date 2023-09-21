terraform {
  backend "s3" {
    bucket = "iac-lab-bucket-tfstate"
    key = "iac"
    dynamodb_table = "iac-lab-terraform-state-lock"
  }
}
