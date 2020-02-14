output "ca_client_private_ip" {
  description = "SSH CA Client Private IP Address"
  value       = aws_instance.ca.*.private_ip
}

output "ca_client_public_ip" {
  description = "SSH CA Client Public IP Address"
  value       = aws_instance.ca.*.public_ip
}

output "otp_client_private_ip" {
  description = "SSH OTP Client Private IP Address"
  value       = aws_instance.otp.*.private_ip
}

output "otp_client_public_ip" {
  description = "SSH OTP Client Public IP Address"
  value       = aws_instance.otp.*.public_ip
}

/* 
Output file to highlight customized outputs that are useful 
(compared to the hundreds of attributes Terraform stores)
To see the output after the apply, use the command: "terraform output"
Note: Since we're using the official VPC and sg modules, you can NOT
create your own outputs for those modules, unless you create them as 
outputs for a new module (and nest these modules within)
 */

// output "cluster_size" {
//   value = length(aws_instance.cluster_master) + length(aws_instance.cluster_workers)
// }