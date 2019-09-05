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


resource "aws_route53_record" "subdomain_root_records" {
  zone_id = data.aws_route53_zone.root.zone_id
  name = "${var.subdomain}.${var.root_domain_name}"
  type = "NS"
  ttl = "30"

  records = [
    aws_route53_zone.subdomain.name_servers[0],
    aws_route53_zone.subdomain.name_servers[1],
    aws_route53_zone.subdomain.name_servers[2],
    aws_route53_zone.subdomain.name_servers[3],
  ]
}