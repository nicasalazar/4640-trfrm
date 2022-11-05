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
2. Create a new API key and copy the key
3. Remote into you Ubuntu host machine and create a .env file
4. Add the following to your .env file

```bash
export TF_VAR_do_token=<your api key>
```
