### --- SSH SG --- ###
resource "aws_security_group" "ssh" {
  name_prefix = "ssh-${var.env_id}-SG"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ssh_trusted_ips
    content {
      cidr_blocks = ingress.value
      description = join("", ["SSH-", ingress.key])
      from_port   = 22
      protocol    = "tcp"
      to_port     = 22
    }
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "coax-${var.env_id}-SG"
    App       = "all"
    Role      = "firewall"
    Env       = var.env_id
    ProjectId = var.project_id
    Terraform = "true"
  }
}

### --- WEB Security Group --- ###
resource "aws_security_group" "web" {
  name_prefix = "web-${var.env_id}-SG"
  description = "Allow HTTP inbound traffic"
  vpc_id      = data.aws_vpc.selected.id

  dynamic "ingress" {
    for_each = var.ssh_trusted_ips
    content {
      cidr_blocks = ingress.value
      description = join("", ["HTTP-", ingress.key])
      from_port   = 80
      protocol    = "tcp"
      to_port     = 80
    }
  }

  dynamic "ingress" {
    for_each = var.ssh_trusted_ips
    content {
      cidr_blocks = ingress.value
      description = join("", ["HTTPS-", ingress.key])
      from_port   = 443
      protocol    = "tcp"
      to_port     = 443
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-${var.env_id}-SG"
    App  = "Backend"
    Role = "Firewall"
  }
}

### --- MON SG --- ###
resource "aws_security_group" "mon" {
  name_prefix = "mon-${var.env_id}-SG"
  description = "Allow Prometheus Monitoring"
  vpc_id      = data.aws_vpc.selected.id

  dynamic "ingress" {
    for_each = var.mon_trusted_ips
    content {
      cidr_blocks = ingress.value
      description = join("", ["cAdv-", ingress.key])
      from_port   = 8080
      protocol    = "tcp"
      to_port     = 8080
    }
  }

  dynamic "ingress" {
    for_each = var.mon_trusted_ips
    content {
      cidr_blocks = ingress.value
      description = join("", ["nEx-", ingress.key])
      from_port   = 9100
      protocol    = "tcp"
      to_port     = 9100
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "mon-${var.env_id}-SG"
    App       = "Backend"
    Role      = "Firewall"
  }
}

### --- DB Security Group --- ###
resource "aws_security_group" "data" {
  name_prefix = "data-${var.env_id}-SG"
  description = "Allow Connect to Postges and Redis"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    security_groups = [aws_security_group.ssh.id]
    description     = "Allow COAX trusted IP"
    from_port       = 5432
    protocol        = "tcp"
    to_port         = 5432
  }
  
  ingress {
    security_groups = [aws_security_group.ssh.id]
    description     = "Allow COAX trusted IP"
    from_port       = 6379
    protocol        = "tcp"
    to_port         = 6379
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "data-${var.env_id}-SG"
    App  = "Data"
    Role = "Firewall"
  }
}
