# output "ec2_public_ip" {
# 	value = aws_instance.my_instance[*].public_ip # <we can fill this by interpolation>
# }

# output "ec2_public_dns" {
# 	value = aws_instance.my_instance[*].public_dns # <we can fill this by interpolation>
# }

# output "ec2_private_ec2" {
# 	value = aws_instance.my_instance[*].private_ip # <we can fill this by interpolation>
# }

output "ec2_public_ip" { # output block for EC2 public IP addresses
	value = { # output value is a map of instance names to public IP addresses
		for instance_name, instance in aws_instance.my_instance : instance_name => instance.public_ip # for each instance, map the instance name to its public IP address
	}
}	