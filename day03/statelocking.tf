terraform {
  backend "s3" {
    bucket       = "ansari-abdul-basit-bucket"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
