# variable.tf

variable "ec2_instance_type" {
	default = "t3.micro"
	type = string
}

variable "ec2_root_default_storage_size" {
	default = 20
	type = number
}

variable "ec2_ami" {
	default = "ami-01a00762f46d584a1"
	type = string
}

variable "env" {
	default = "prod"
	type = string
}