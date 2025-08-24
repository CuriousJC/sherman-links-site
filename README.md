## sherman-links-site
This is a simple static content website that is deployed/hosted on an s3 bucket in AWS.  It runs a GitHub Actions workflow on commit to update teh s3 bucket contents using terraform.

## Repository Structure

### `.github/workflows`
GitHub Actions workflow files. Runs creation/destroy terraform to keep content up-to-date.

### `site`
The `site` directory holds the static content for the site and is directly sent to the s3 host.

### `terraform`
The `terraform` directory contains infrastructure-as-code configurations using [Terraform](https://www.terraform.io/). These scripts define and provision cloud resources and environments in a declarative way, enabling automated deployments and infrastructure management.

