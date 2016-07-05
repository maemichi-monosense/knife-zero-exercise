# command options
local_mode true
knife[:ssh_user] = 'ec2-user'
knife[:use_sudo] = true

knife[:editor] = 'subl -w'

knife[:automatic_attribute_whitelist] = [
  "fqdn/",
  "os/",
  "os_version/",
  "hostname",
  "ipaddress/",
  "roles/",
  "recipes/",
  "ipaddress/",
  "platform/",
  "platform_version/",
  "platform_version/",
  "cloud/",
  "cloud_v2/",
  "ec2/ami_id/",
  "ec2/instance_id/",
  "ec2/instance_type/",
  "ec2/placement_availability_zone/",
  "chef_packages/"
]
