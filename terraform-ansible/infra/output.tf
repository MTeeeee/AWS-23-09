output "web_ip" {
  value = "http://${module.create_ec2.ip}"
}

resource "local_file" "private_key" {
  content  = templatefile("key_template.tmpl", 
  {
    ec2_ip = "${module.create_ec2.ip}"
  }
  )
  filename = "../ansible/hosts"
}
