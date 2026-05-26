output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "route_table_id" {
  description = "Route table ID the route belongs to"
  value       = try(aws_route.this[0].route_table_id, null)
}

output "destination_cidr_block" {
  description = "Destination CIDR of the route"
  value       = try(aws_route.this[0].destination_cidr_block, null)
}
