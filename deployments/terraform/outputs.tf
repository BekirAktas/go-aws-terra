output "go_aws_terra_vpc_id" {
  value = aws_vpc.go_aws_terra_main_vpc.id
}

#output "go_aws_terra_cluster_name" {
#  value = module.eks.cluster_name
#}
#
#output "go_aws_terra_rds_endpoint" {
#  value = aws_db_instance.go_aws_terra_main_db_instance.endpoint
#}

output "eip_allocation_id" {
  value = aws_eip.eip-nat-gateway.id
}
