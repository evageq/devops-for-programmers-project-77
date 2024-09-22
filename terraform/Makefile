init:
	@terraform init
	@terraform apply
	@terraform output -json > ${TOP_DIR}/ansible/ansible_vars.json

destroy:
	terraform destroy
