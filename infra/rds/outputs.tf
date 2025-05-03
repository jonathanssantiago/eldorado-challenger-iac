output "rds_eldorado_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = aws_db_instance.eldorado_db.endpoint
}
