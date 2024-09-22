init: setup encrypt inventory requirements

deploy:
	ansible-playbook -i inventory.ini --tags deploy playbook.yml

requirements:
	ansible-galaxy install -r requirements.yml

setup:
	ansible-playbook -i inventory.ini --tags setup playbook.yml

encrypt:
	ansible-vault encrypt group_vars/webservers/vault.yml

inventory:
	ansible-playbook -i inventory.ini -v gen_inv.yml
