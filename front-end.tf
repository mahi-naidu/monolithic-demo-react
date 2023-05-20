#frontend.tf

resource "aws_security_group" "frontend" {
  name        = "frontend"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.demo.id

  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.envname}-frontendsg"
  }
}

resource "aws_key_pair" "demo" {
  key_name   = "demo"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCWXmBRw1kJLqrvM467ws7OCpGEuB028Xd39x2FQxyueQ69BPJ73E3+yi9SFQGCUsXy/MwKkA0JswihUayrd4sLfs9YFvp97qgBDGXy5A0PNWVARP48LDROBGOw1IuVO0/LavibIVvOthGgeWZ5lkO5jPe76i42VQ+zeWdDFUbrHxQ3YqiBs1ZrLVVkhqGlFg6nuqk62Ac7o69zCogUU3nkiRHtAiAxBeF83uJA3+6BlrLMB2/6tnUYG/yRY4C876FxYpxuzW+tv2Xth0dw0mnkzYKzmYwSVsOrSmcDbNb0LUUmCAFyTdN0C7awda3rf2F9rp9Th+3v8OrZnHMbmXbm8+Nlv9awvskm/i0EblhMDzB4dYn7KPWee+hyI1oZ/I1scTADYCaqEuqYp8SPWbjrKuqdFbtGPDoFthaTKXk0WKGBjHneQPSL3mcqRd80LHrVxlZxC+EzaSWnKjcOtWweAAeIh1GSLaCKxohZUMCzdhsovBe0AzLWjLw5JqF2Ex8= b.magesh@FVFH83KZQ05N"
  }

# data "template_file" "userdata1" {
#   template = file("backenduserdata.sh")

# }

resource "aws_instance" "frontend" {
  ami                    = var.ami
  instance_type          = var.type
  key_name               = aws_key_pair.demo.id
  vpc_security_group_ids = ["${aws_security_group.frontend.id}"]
  subnet_id              = aws_subnet.pubsubnets[0].id
  #user_data              = data.template_file.userdata1.rendered

  tags = {
    Name = "${var.envname}-frontend"
  }
}
