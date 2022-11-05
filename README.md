# Terraform Instructions

### Terraform Installation in Ubuntu/Debian

1. Install HashiCorp's Debian package repository.
```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

```

2. Install the HashiCorp GPG key.
```bash

wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
```

3. Verify the key's fingerprint.
```bash
gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint
```

4. Add the official HashiCorp repository
```bash
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
```

5. Download HashiCorp package information & Install Terraform
```bash
sudo apt update
sudo apt-get install terraform
```

### Create a API Key in Digital Ocean
1. Create a digitocean account
2. Generate a new API key and copy the key
3. Remote into you Ubuntu host machine and create a .env file
4. Add the following to your .env file

```bash
export TF_VAR_do_token=<your api key>
```

### Create a Digital Ocean Provider
1. Create a main.tf file in your Ubuntu local machine
2. Configure main.tf with the proper credentials

```bash
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
```
3. Initialize your main.tf

```bash
terraform init
```
4. This will create a new .terraform and a .terraform_loc.hcl folder in your directory

### Adding Configurations to main.tf File
1. Edit you main.tf file again and add the configuration for your ssh key and digital ocean project

```bash
data "digitalocean_ssh_key" "my_ssh_key" {
        name = "ACIT4640_Lab_Key"
}

data "digitalocean_project" "lab_project" {
        name = "ACIT4640-Lab"
}
```
2. Create a new tag configuration
```bash
resource "digitalocean_tag" "do_tag" {
        name = "Web"
}
```
3. Create a VPC configuration
```bash
resource "digitalocean_vpc" "web_vpc" {
  name   = "4640_labs"
  region = "sfo3"
}
```
4. Create a new Web Droplet configuration in the sfo3 region
```bash
resource "digitalocean_droplet" "web" {
  image    = "rockylinux-9-x64"
  name     = "web-1"
  tags     = [digitalocean_tag.do_tag.id]
  region   = "sfo3"
  size     = "s-1vcpu-512mb-10gb"
  ssh_keys = [data.digitalocean_ssh_key.4640_Lab.id]
  vpc_uuid = digitalocean_vpc.web_vpc.id
}
```

