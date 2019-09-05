data "aws_caller_identity" "this" {}
data "aws_region" "current" {}

locals {
  name = var.name
  common_tags = {
    "Terraform" = true
    "Environment" = var.environment
    "Name" = var.name
  }

  tags = merge(var.tags, local.common_tags)
}

data "aws_route53_zone" "root" {
  name = "${var.root_domain_name}."
}

resource "aws_route53_zone" "subdomain" {
  name = "${var.subdomain}.${var.root_domain_name}."

  tags = local.tags
}
