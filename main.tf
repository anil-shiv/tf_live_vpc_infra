
resource "aws_vpc" "main" {
  cidr_block                       = var.cidr
  enable_dns_support               = var.enable_dns_support
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_classiclink               = var.enable_classiclink
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block

  tags = {
    BusinessUnit = var.business_unit
    Name         = var.name
    App          = var.app_tag
    ManagedBy    = var.managed_by
    Environment  = var.environment
    Role         = "Main VPC"
    Provisioner  = "Terraform"
  }

}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    BusinessUnit = var.business_unit
    Name         = var.name
    App          = var.app_tag
    ManagedBy    = var.managed_by
    Environment  = var.environment
    Role         = "Main Internet Gateway"
    Provisioner  = "Terraform"
  }
}

resource "aws_eip" "nat" {
  count = length(var.dmz_standard_subnet_cidrs)
  vpc   = true

  tags = {
    BusinessUnit = var.business_unit
    Name         = var.name
    App          = var.app_tag
    ManagedBy    = var.managed_by
    Environment  = var.environment
    Role         = "NAT EIP"
    Provisioner  = "Terraform"
  }
}

resource "aws_nat_gateway" "main" {
  count         = length(var.dmz_standard_subnet_cidrs)
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(module.dmz_standard_subnet.subnet_ids, count.index)
  depends_on    = [aws_internet_gateway.main]

  tags = {
    BusinessUnit = var.business_unit
    Name         = var.name
    App          = var.app_tag
    ManagedBy    = var.managed_by
    Environment  = var.environment
    Role         = "main NAT Gateway"
    Provisioner  = "Terraform"
  }
}


module "dmz_senitive_subnet" {
  source = "git@github.com:anil-shiv/tf_aws_public_subnet.git"

  name                = "${var.environment}-dmz_sensitive"
  cidrs               = var.dmz_sensitive_subnet_cidrs
  azs                 = var.avalibility_zone
  vpc_id              = aws_vpc.main.id
  igw_id              = aws_internet_gateway.main.id
  business_unit       = var.business_unit
  env                 = var.environment
  app_tag             = var.app_tag
  managed_by          = var.managed_by
  data_classification = "sensitive"
  tier                = "dmz"

}

module "dmz_standard_subnet" {
  source = "git@github.com:anil-shiv/tf_aws_public_subnet.git"

  name                = "${var.environment}-dmz_standard"
  cidrs               = var.dmz_standard_subnet_cidrs
  azs                 = var.avalibility_zone
  vpc_id              = aws_vpc.main.id
  igw_id              = aws_internet_gateway.main.id
  business_unit       = var.business_unit
  env                 = var.environment
  app_tag             = var.app_tag
  managed_by          = var.managed_by
  data_classification = "standard"
  tier                = "dmz"

}

module "db_standard_subnet" {
  source = "git@github.com:anil-shiv/tf_aws_private_subnet_nat_gateway.git"


  name                = "${var.environment}-db_standard"
  cidrs               = var.db_standard_subnet_cidrs
  azs                 = var.avalibility_zone
  vpc_id              = aws_vpc.main.id
  nat_gateway_ids     = aws_internet_gateway.main.*.id
  public_subnet_ids   = module.dmz_standard_subnet.subnet_ids
  business_unit       = var.business_unit
  env                 = var.environment
  app_tag             = var.app_tag
  managed_by          = var.managed_by
  data_classification = "standard"
  tier                = "db"
}