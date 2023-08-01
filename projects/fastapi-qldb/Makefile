.PHONY: clean

export TF_ENV = "dev"

	terraform get -update=true
	terraform init -reconfigure -backend-config=config/${TF_ENV}/backend-${TF_ENV}.conf
	terraform plan -var-file=config/${TF_ENV}/${TF_ENV}.tfvars
	terraform apply -var-file=config/${TF_ENV}/${TF_ENV}.tfvars

destroy:
	terraform destroy -auto-approve

deploy-terra:
	get init plan apply
