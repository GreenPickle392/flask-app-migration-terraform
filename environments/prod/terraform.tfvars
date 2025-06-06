aws_region             = "eu-central-1"
environment            = "prod"
container_image        = "973515032676.dkr.ecr.eu-central-1.amazonaws.com/dokumentenapp"
s3_bucket_name         = "flask-dokumente-prod"
db_name                = "flaskdb"
db_username_secret_id  = "prod/flask-db-username"
db_password_secret_id  = "prod/flask-db-password"
subnet_ids             = ["subnet-0ef85b804e46b5492", "subnet-00984c436f15e7208", "subnet-076a676285e617780"]
vpc_id                 = "vpc-01df2e67e30740434"
allowed_ip_cidr        = "5.146.192.76"
