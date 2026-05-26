variable "route_table_id" {
  description = "ID of the route table"
  type        = string
  validation {
    condition     = length(var.route_table_id) > 0
    error_message = "route_table_id must not be empty."
  }
}

variable "destination_cidr_block" {
  description = "Destination CIDR block for the route"
  type        = string
  default     = "0.0.0.0/0"
}

variable "gateway_id" {
  description = "ID of the internet gateway"
  type        = string
  default     = null
}

variable "nat_gateway_id" {
  description = "ID of the NAT gateway"
  type        = string
  default     = null
}

variable "transit_gateway_id" {
  description = "ID of the transit gateway"
  type        = string
  default     = null
}

variable "vpc_peering_connection_id" {
  description = "ID of the VPC peering connection"
  type        = string
  default     = null
}
