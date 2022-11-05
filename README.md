# Terraform Installation

### Installation in Ubuntu/Debian

1.
```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

```

2.
```bash

wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
```

3.
```bash
gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint
```

4.
```bash
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
```

5.
```bash
sudo apt update
sudo apt-get install terraform
```
