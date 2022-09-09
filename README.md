# AWS VPC Terraform module

Terraform module which creates VPC resources on AWS.

## Usage

```
module "vpc" {
  source = "git@github.com:anil-shiv/tf_live_vpc_infra.git"
  region = "eu-west-1"
  name = "my-vpc"
  cidr = "10.0.0.0/16"

  avalibility_zone  = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  dmz_standard_subnet_cidrs   = ["10.0.3.0/24"]
  dmz_sensitive_subnet_cidrs    = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}
```

#### Sub module
`dmz_senitive_subnet` It is going to use to create Public subnet and route table
`db_standard_subnet` It is going to use create Private Subnet and route table.
