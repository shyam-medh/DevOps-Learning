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
    key_name = aws_key_pair.my_key.key_name // reference to the key pair name
    security_groups = [aws_security_group.my_security_group.name] // reference to the security group name
    instance_type = "t3.micro" // instance type
    ami = "ami-01a00762f46d584a1" # AMI ID for Amazon Linux 2 in ap-south-1 region
    root_block_device{ // root block device configuration
        volume_size = 15 // size of the root volume in GB
        volume_type = "gp3" // type of the root volume
    }
    tags = {
        Name = "terraform-learn" // tag for the EC2 instance
    }
}