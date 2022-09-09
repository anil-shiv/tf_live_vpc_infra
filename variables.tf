variable "name" {
  description = "Name tag eg stack"
  default = "my-vpc"
}

variable "region" {
  description = "AWS reagion in Which resources are created, You must set the avalibility_zone variable as well if you define this value something other than the default"
  default = "us-east-1"
}

variable "avalibility_zone" {
  description = "A comma-separated list of avalibility zones"
  type        = list(string)
  default = [ "us-east-1a","us-east-1b" ]
}

variable "environment" {
  description = "Environment tag, recommmendation: <account name>_<region>, e.g. dev_us-east-1"
  default = "dev_us-east-1"
}

variable "business_unit" {
  description = "Business unit within organization (e.g. Consumer)"
  default = "Consumer"
}

variable "app_tag" {
  description = "APP tag eg. Plateform, DevOps"
  default = "DevOps"
}

variable "managed_by" {
  description = "Managed by eg. Plateform, DevOps"
  default = "DevOps"
}

variable "cidr" {
  description = "CIDR block for VPC"
  default = "10.0.0.0/16"
}

variable "enable_dns_support" {
  default = "true"
}

variable "enable_classiclink" {
  default = "false"
}

variable "enable_dns_hostnames" {
  default = "true"
}

variable "assign_generated_ipv6_cidr_block" {
  default = "false"
}

variable "aws_vpn_gateway" {
  description = "Bool to add a vpn gateway to the vpc or not. A VPN gateway is needed to use Directconnect. Default : 0"
  default     = "0"
}

variable "dmz_standard_subnet_cidrs" {
  description = "List of subnet block for dmz subnet for 'standard' data"
  type        = list(string)
  default     = ["10.0.3.0/24"]
}

variable "dmz_sensitive_subnet_cidrs" {
  description = "List of subnet block for dmz subnet for 'sensitive' data"
  type        = list(string)
  default     = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "web_standard_subnet_cidrs" {
  description = "List of subnet block for web subnet for 'standard' data"
  type        = list(string)
  default     = []
}

variable "web_sensitive_subnet_cidrs" {
  description = "List of subnet block for web subnet for 'sensitive' data"
  type        = list(string)
  default     = []
}

variable "app_standard_subnet_cidrs" {
  description = "List of subnet block for app subnet for 'standard' data"
  type        = list(string)
  default     = []
}

variable "app_sensitive_subnet_cidrs" {
  description = "List of subnet block for app subnet for 'sensitive' data"
  type        = list(string)
  default     = []
}

variable "db_standard_subnet_cidrs" {
  description = "List of subnet block for db subnet for 'standard' data"
  type        = list(string)
  default     = []
}

variable "db_sensitive_subnet_cidrs" {
  description = "List of subnet block for db subnet for 'sensitive' data"
  type        = list(string)
  default     = []
}

variable "admin_subnet_cidrs" {
  description = "list of subnet blocks for admin subnet for 'admin' data"
  type        = list(string)
  default     = []
}

variable "tgw_subnet_cidrs" {
  description = "list of subnet block for tgw subnet for 'tgw' data"
  type        = list(string)
  default     = []
}

variable "enable_endpoints_s3" {
  description = "create a S3 VPC endpoint for all Subnets"
  default     = "true"
}

variable "enable_endpoints_dynamodb" {
  description = "create a Dynamodb VPC endpoint for all Subnets"
  default     = "true"
}
