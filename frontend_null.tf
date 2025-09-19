resource "null_resource" "cluster" {
  count = length(var.private_subnet_cidr)

  provisioner "file" {
    source      = "user-data.sh"
    destination = "/tmp/user-data.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("terr.pem")
      # host     = "${element(aws_instance.public-server.*.public_ip,count.index)}"
      host = element(aws_instance.frontend_ec2.*.public_ip, count.index)

    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 700 /tmp/user-data.sh",
      "sudo /tmp/user-data.sh",
      "sudo apt update",
      "sudo apt install jo unzip -y"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("terr.pem")
      host        = element(aws_instance.public_ec2.*.public_ip, count.index)
    }
  }
}