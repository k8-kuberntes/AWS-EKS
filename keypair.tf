## keypair for ec2 to login
resource "aws_key_pair" "main-key" {
  key_name   = "${var.key_name}"
  public_key = "${file("./it-admin-key.pub")}"
}
