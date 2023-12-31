variable linux_image_id {}
variable windows_image_id {}
variable server_instance_type {}
variable gateway_instance_type {}
variable opa_enrollment {}

resource "aws_instance" "ec2_instance_gateway" {
  ami                         = var.linux_image_id
  associate_public_ip_address = true
  instance_type               = var.gateway_instance_type
  vpc_security_group_ids      = [aws_security_group.opa_gateway_defaults.id]
  user_data                   = join("\n", [
    templatefile("./aws-infrastructure/scripts/server-enrollment-linux.tftpl", {
      name  = "ubuntu-gateway"
      token = var.opa_enrollment.gateway_enrollment_token
    }),
    templatefile("./aws-infrastructure/scripts/gateway-enrollment.tftpl", {
      token                   = var.opa_enrollment.gateway_setup_token
      sessionRecordingHandler = templatefile("./aws-infrastructure/scripts/gateway-session-recording-handler.tftpl", {
        s3key    = aws_iam_access_key.s3_access_key.id
        s3secret = aws_iam_access_key.s3_access_key.secret
        s3region = var.region
        s3bucket = aws_s3_bucket.s3_bucket.bucket
      })
    })
  ])
  tags = {
    Name = "opa-ubuntu-gateway"
  }
}

resource "aws_instance" "ec2_instance_linux_server" {
  ami                         = var.linux_image_id
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.network_private_subnet_az1.id
  instance_type               = var.server_instance_type
  vpc_security_group_ids      = [aws_security_group.opa_linux_defaults.id]
  user_data                   = templatefile("./aws-infrastructure/scripts/server-enrollment-linux.tftpl", {
    name  = "ubuntu-server"
    token = var.opa_enrollment.linux_enrollment_token
  })
  tags = {
    Name = "opa-ubuntu-server"
  }
}

resource "aws_instance" "ec2_instance_windows_server_non-ad" {
  ami                         = var.windows_image_id
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.network_private_subnet_az1.id
  instance_type               = var.server_instance_type
  vpc_security_group_ids      = [aws_security_group.opa_windows_defaults.id]
  user_data                   = templatefile("./aws-infrastructure/scripts/server-enrollment-windows.tftpl", {
    name  = "windows-server-nonad"
    token = var.opa_enrollment.windows_non-ad_enrollment_token
  })
  tags = {
    Name = "opa-windows-server-nonad"
  }
}
