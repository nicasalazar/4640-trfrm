# Terraform Installation

### Installation using Ubuntu

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
