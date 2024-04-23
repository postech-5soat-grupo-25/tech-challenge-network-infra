terraform {
  backend "s3" {
    bucket         = "postech-5soat-grupo-25-tfstate"
    key            = "network/state"
    region         = "us-east-1"
    dynamodb_table = "postech-5soat-grupo-25-tflocks"
    encrypt        = true
  }
}