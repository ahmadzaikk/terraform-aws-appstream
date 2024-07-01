# output "stack_name" {
#   description = "The name of the AppStream 2.0 stack"
#   value       = aws_appstream_stack.this.name
#   }

  output "name" {
  description = "The name of the AppStream 2.0 fleet"
  value       = aws_appstream_fleet.this.name
  }