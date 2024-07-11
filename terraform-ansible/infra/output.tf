output "web_ip" {
  value = "http://${module.create_ec2.ip}"
}