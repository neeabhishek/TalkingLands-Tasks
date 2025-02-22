variable "access_key" {
  type    = string
  default = "" #Pass your IAM user access_key
}
variable "secret_key" {
  type    = string
  default = "" #Pass your IAM user secret_key
}
variable "region" {
  type    = string
  default = "ap-south-1"
}
variable "environment" {
  type    = string
  default = "Dev"
}
variable "ami" {
  type    = string
  default = "ami-00bb6a80f01f03502"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "filename" {
  type    = string
  default = "talkingLands_nginxServer.pem"
}
variable "file_permission" {
  type    = string
  default = "0755"
}
variable "nginx_server_user" {
  type    = string
  default = "ubuntu" #By default Ubuntu AMI has user name as ubuntu
}
variable "cidr_blocks" {
  type    = string
  default = "0.0.0.0/0"
}