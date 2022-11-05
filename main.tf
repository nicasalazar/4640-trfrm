terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Set the variable value in *.tfvars file
variable "do_token" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "ssh_key" {
	name = "4640_Lab"
}

data "digitalocean_project" "lab_project" {
	name = "ACIT4640-Lab"
}

# Create a new tag
resource "digitalocean_tag" "do_tag" {
  name = "Web"

}

# Create new VPC
resource "digitalocean_vpc" "web_vpc" {
  name   = "4640_labs"
  region = "sfo3"
}

# Create a new Web Droplet in the sfo3 region
resource "digitalocean_droplet" "web" {
  image    = "rockylinux-9-x64"
  name     = "web-1"
  tags     = [digitalocean_tag.do_tag.id]
  region   = "sfo3"
  size     = "s-1vcpu-512mb-10gb"
  ssh_keys = [data.digitalocean_ssh_key.4640_Lab.id]
  vpc_uuid = digitalocean_vpc.web_vpc.id
}

# Add new web-1 droplet to exisitng ACIT4640-Lab project
resource "digitalocean_project_resources" "project_attach" {
  project = data.digitalocean_project.lab_project.id
  resources = [
    digitalocean_droplet.web.urn
  ]
}

output "server_ip" {
  value = digitalocean_droplet.web.ipv4_address
}

