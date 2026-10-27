resource "aws_instance" "my_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [var.vpc_security_group_id]
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  tags = {
    Name = var.instance_name
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install docker.io -y
                sudo systemctl start docker
                sudo systemctl enable docker
                sudo apt install -y fontconfig openjdk-21-jre
                DD_API_KEY=79bc0012e38ff36e7048203fd1a9311a \
                DD_SITE="datadoghq.com" \
                bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"
            EOF
}
