module "bucket"{
    source = "./modules/bucket-aws"
    bucket_prefix = "terraform-bucket-posmack"
    region = "us-east-2"

}


resource "aws_s3_object" "index_html" {
  key    = "index.html"
  bucket = module.bucket.aws-bucket-id
  source = "./files/index.html"
}