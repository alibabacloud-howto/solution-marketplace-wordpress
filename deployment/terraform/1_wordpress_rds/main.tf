provider "alicloud" {
  #   access_key = "${var.access_key}"
  #   secret_key = "${var.secret_key}"
  region = "ap-southeast-1"
}

variable "zone_1" {
  default = "ap-southeast-1b"
}

variable "name" {
  default = "wp_group"
}

######## Security group
resource "alicloud_security_group" "group" {
  name        = "sg_solution_cloud_native_wordpress"
  description = "Security group for cloud native wordpress solution"
  vpc_id      = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "allow_http_80" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_https_443" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "443/443"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_ssh_22" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_rdp_3389" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "3389/3389"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_all_icmp" {
  type              = "ingress"
  ip_protocol       = "icmp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

######## VPC
resource "alicloud_vpc" "vpc" {
  vpc_name   = var.name
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "vswitch_1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = var.zone_1
  vswitch_name = "vsw_on_zone_1"
}

####### RDS MySQL
variable "rds_mysql_name" {
  default = "rds_mysql"
}

resource "alicloud_db_instance" "instance" {
  engine                   = "MySQL"
  engine_version           = "5.7"
  instance_type            = "mysql.n2.small.1"
  instance_storage         = "20"
  db_instance_storage_type = "cloud_essd"
  instance_charge_type     = "Postpaid"
  vswitch_id               = alicloud_vswitch.vswitch_1.id
  security_group_ids       = [alicloud_security_group.group.id]
  instance_name            = var.rds_mysql_name
}

resource "alicloud_db_account" "account" {
  db_instance_id   = alicloud_db_instance.instance.id
  account_name     = "wordpress"
  account_password = "N1cetest"
}

resource "alicloud_db_database" "default" {
  instance_id = alicloud_db_instance.instance.id
  name        = "wordpress"
}

resource "alicloud_db_account_privilege" "privilege" {
  instance_id  = alicloud_db_instance.instance.id
  account_name = alicloud_db_account.account.name
  privilege    = "ReadWrite"
  db_names     = alicloud_db_database.default.*.name
}

######## ECS
##### Use the Workpress image in Marketplace: 
##### https://marketplace.alibabacloud.com/products/56720001/WP_CMS_on_LAMP-sgcmjj00025386.html
resource "alicloud_instance" "instance" {
  security_groups = alicloud_security_group.group.*.id

  # series III
  instance_type           = "ecs.n1.medium"
  system_disk_category    = "cloud_ssd"
  system_disk_name        = "wp_system_disk_name"
  system_disk_size        = 40
  system_disk_description = "wp_system_disk_description"
  image_id                = "m-t4nbzugfiorb4ysbm9zq"
  instance_name           = "wp"
  password                = "N1cetest" ## Please change accordingly
  instance_charge_type    = "PostPaid"
  vswitch_id              = alicloud_vswitch.vswitch_1.id
  data_disks {
    name        = "disk2"
    size        = 100
    category    = "cloud_efficiency"
    description = "disk2"
    # encrypted   = true
    # kms_key_id  = alicloud_kms_key.key.id
  }
}

######## EIP bind to wordpress setup ECS accessing from internet
resource "alicloud_eip" "setup_ecs_access" {
  bandwidth            = "10"
  internet_charge_type = "PayByBandwidth"
}

resource "alicloud_eip_association" "eip_ecs" {
  allocation_id = alicloud_eip.setup_ecs_access.id
  instance_id   = alicloud_instance.instance.id
}

######### Output: EIP of ECS
output "eip_ecs" {
  value = alicloud_eip.setup_ecs_access.ip_address
}

######### Output: RDS URL
output "rds_url" {
  value = alicloud_db_instance.instance.connection_string
}
