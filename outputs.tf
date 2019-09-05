output "route53_zone_id" {
  value = aws_route53_zone.subdomain.zone_id
}

output "route53_zone_ns_records" {
  value = aws_route53_zone.subdomain.name_servers
}