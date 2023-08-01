# <p align="center"> <img src="assets/imgs/database.gif" width="5%"/> **FASTAPI + QLDB Integration Project** <img src="assets/imgs/database.gif" width="5%"/> </p>

This project implements a Data Pipeline that takes application requests using FastAPI and inserts them into an `Amazon QLDB`. This whole project was built on top of `Terraform` as an IaC (Infrastructure as Code) tool and using AWS services.

## **Architecture** :triangular_ruler:
This section shows a diagram of the project architecture. It shows how AWS services and project elements interact with each other.

<p align="center">
    <img src="assets/imgs/data_pipeline_architecture.drawio.png" width="100%"/>
</p>

## **Services** :space_invader:
This section of the documentation gives an explanation about all the AWS services that were used in this project.


- [Amazon QLDB](https://aws.amazon.com/qldb/): Amazon Quantum Ledger Database (Amazon QLDB) is a fully managed ledger database that provides a transparent, immutable, and cryptographically verifiable transaction log.

- [Amazon Simple Storage Service](https://aws.amazon.com/s3/): Amazon Simple Storage Service (Amazon S3) is an object storage service offering industry-leading scalability, data availability, security, and performance. Customers of all sizes and industries can store and protect any amount of data for virtually any use case, such as data lakes, cloud-native applications, and mobile apps. With cost-effective storage classes and easy-to-use management features, you can optimize costs, organize data, and configure fine-tuned access controls to meet specific business, organizational, and compliance requirements.

## **Tools** :wrench:
This section of the documentation mention all the tools an technologies that were used in this project.

- [Terraform](https://www.terraform.io/): HashiCorp Terraform is an infrastructure as code tool that lets you define both cloud and on-prem resources in human-readable configuration files that you can version, reuse, and share.

- [Python](https://www.python.org/): Python is an interpreted, object-oriented, high-level programming language with dynamic semantics. Its high-level built in data structures, combined with dynamic typing and dynamic binding, make it very attractive for Rapid Application Development, as well as for use as a scripting or glue language to connect existing components together.

- [FastAPI](https://aws.amazon.com/qldb/): FastAPI is a modern, fast (high-performance), web framework for building APIs with Python 3.7+ based on standard Python type hints.

- [GitHub Actions](https://github.com/features/actions): GitHub Actions is a continuous integration and continuous delivery (CI/CD) platform that allows you to automate your build, test, and deployment pipeline. You can create workflows that build and test every pull request to your repository, or deploy merged pull requests to production.

## **Setup** :rocket:

- Go to GitHub Repo Settings, on the menu to the left, click on `Secrets and variables`, then on `Actions` and create the following:
  - Secrets:
    - AWS_ACCESS_KEY_ID
    - AWS_SECRET_ACCESS_KEY
    - AWS_REGION
  - Variables:
    - TFSTATE_BUCKET: Name of the bucket that will be created in your AWS account, that will store the .tfstate file
    - QLDB_EXPORT_BUCKET: Name of the bucket that will be created in your AWS account, that will store the files from QLDB Export.

- Run manually the actions using, the following workflows (if you want to deploy on push, merge, or PR, check the following https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows)
  - Deploy FASTAPI + QLDB project: To deploy the resources on the AWS Account
  - Destroy FASTAPI + QLDB project: Delete all resources of your AWS Account using the .tfstate file stored in the S3 TFSTATE_BUCKET.

- `cd` into `./projects/fastapi-qldb/modules/qldb_interactions` and run the following command to launch the API server.
  - `uvicorn run:app --reload`
- Interact with the QLDB using the different API calls and methods.