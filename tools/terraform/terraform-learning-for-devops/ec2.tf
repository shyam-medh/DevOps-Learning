// key pair

resource "aws_key_pair" "my_key"{ // resource name
    key_name = "terra-key-ec2" // name of the key pair
    public_key = file("terra-key-ec2.pub")  // path to the public key file
}

// vpc & security group

resource "aws_default_vpc" "my_vpc"{

}

resource "aws_security_group" "my_security_group"{ // resource name
    name = "automate-sg" // name of the security group
    description = "This will add a TF generated security group" // description of the security group
    vpc_id = aws_default_vpc.my_vpc.id // reference to the default VPC ID

    // inbound rules
    ingress{
        from_port = 22 // port number for SSH
        to_port = 22 // port number for SSH
        protocol = "tcp" // protocol type
        cidr_blocks = ["0.0.0.0/0"] // allow access from any IP address
        description = "SSH open"
    }
    ingress{
        from_port = 80 // port number for HTTP
        to_port = 80 // port number for HTTP
        protocol = "tcp" // protocol type
        cidr_blocks = ["0.0.0.0/0"] // allow access from any IP address
        description = "HTTP open"
    }
    ingress{
        from_port = 8000 // port number for custom application
        to_port = 8000 // port number for custom application
        protocol = "tcp" // protocol type
        cidr_blocks = ["0.0.0.0/0"] // allow access from any IP address
        description = "Flask APP"
    }

    // outbound rules
    egress{
        from_port = 0 // port number for all traffic
        to_port = 0 // port number for all traffic
        protocol = "-1" // protocol type for all traffic
        cidr_blocks = ["0.0.0.0/0"] // allow access from any IP address
        description = "Allow all outbound traffic" // description of the rule
    }

    tags = {
        Name = "automate-sg" // tag for the security group
    }
}

// ec2 instance

resource "aws_instance" "my_instance"{ // resource name
    # count = 3 // this is the meta argument that allows us to create multiple instances of the same resource
    for_each =({
        instance-tws-micro = "t3.micro"
        instance-tws-medium = "t3.medium"
    })

    depends_on = [aws_security_group.my_security_group] // ensure that the security group is created before the EC2 instance

    key_name = aws_key_pair.my_key.key_name // reference to the key pair name
    security_groups = [aws_security_group.my_security_group.name] // reference to the security group name
    instance_type = each.value// instance type
    ami = var.ec2_ami # AMI ID for Amazon Linux 2 in ap-south-1 region
    user_data = file("install_nginx.sh") // path to the user data script for installing nginx
    root_block_device{ // root block device configuration
        volume_size = var.env == "dev" ? 10 : var.ec2_root_default_storage_size // size of the root volume in GB
        volume_type = "gp3" // type of the root volume
    }
    tags = {
        Name = each.key // tag for the EC2 instance
    }
}


// this is for importing an existing EC2 instance into Terraform state file. 
// This is useful when you have an existing EC2 instance that was created outside of Terraform and 
// you want to manage it using Terraform.
resource "aws_instance" "my_new_instance"{ // resource name
    ami = "unknown" // AMI ID for the existing EC2 instance
    instance_type = "unknown" // instance type for the existing EC2 instance
}