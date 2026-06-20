# variable.tf

variable "ec2_instance_type" {
	default = "t3.micro"
	type = string
}

variable "ec2_root_storage_size" {
	default = 20
	type = number
}

variable "ec2_ami" {
	default = "ami-0cb91c7de36eed2cb"
	type = string
}