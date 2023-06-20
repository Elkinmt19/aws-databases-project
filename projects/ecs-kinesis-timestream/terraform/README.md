# <p align="center"> <img src="assets/imgs/terraform_logo.png" width="8%"/> **Terraform** <img src="assets/imgs/terraform_logo.png" width="8%"/> </p>

This service is the main `terraform` module of this project, from here is where the other `terraform` submodules are used in the `modules.tf` file. 

<p align="center">
    <img src="assets/imgs/terraform_big_logo.png" width="80%"/>
</p>

This is the main implementation of the whole infrastructure of this project using Terraform, this project has two different inputs for the Terraform template, one for the environment (QA or PDN).

## **Getting Started** :checkered_flag:
This application can be executed locally using a local Terraform installation. In order to run the application you need to run the following steps:

- Configure the default profile of your installation of the AWS CLI.

- Configure the Terraform project using the terraform init command.
    ```bash
    terraform init
    ```
- Make the plan of your terraform for the QA variables project using the terraform plan command.
    ```bash
    terraform plan -var-file="env/qa/qa.tfvars"
    ```
- Create all the resources using the terraform apply command.
    ```bash
    terraform apply -auto-approve
    ```
- Destroy all the resources created using the terraform destroy command.
    ```bash
    terraform destroy -auto-approve
    ```