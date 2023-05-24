## Strapi Ubuntu Installer

This script installs Strapi onto any Ubuntu server. Ensure that your domain DNS is setup correctly, and then run the command below.

`wget -O strapi_ubuntu_installer.sh <LINK>; chmod u+x strapi_ubuntu_installer.sh; sh strapi_ubuntu_installer.sh -n <PROJECTFOLDERNAME> -e <EMAIL>`

`<PROJECTFOLDERNAME>` being the same as the URL you want to host the Strapi application at, as per your DNS settings. For example, `manage.mycool.com`, or whatever you configured it to be.

`<EMAIL>` is the address that you want to register with Cerbot for HTTPS.
