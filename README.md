## Strapi Ubuntu Installer

This script installs Strapi onto any Ubuntu server. Ensure that your domain DNS is setup and has propagated, and then run the command below.

```
wget -O strapi_ubuntu_installer.sh https://raw.githubusercontent.com/onlyaperitifs/strapi_ubuntu_installer/main/install.sh && chmod u+x strapi_ubuntu_installer.sh && sh strapi_ubuntu_installer.sh
```

What you'll be asked to provide:

- `root domain`: Where you want to point the NGINX reverse proxy
- `email`: Email address for Certbot notifications
