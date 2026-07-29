terraform{
    required_providers{
        aws = {
            source  = "hashicorp/aws"
            version = "~> 6.0"
        }
    }

    backend "s3" {
        bucket = "remote-infra-s3-shyam"
        key    = "terraform.tfstate"
        region = "ap-south-1"
        dynamodb_table = "remote-infra-dynamodb-table-shyam"
    }
}