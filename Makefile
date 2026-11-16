.PHONY: emulator init plan apply destroy fmt validate health reset-state clean

ENDPOINT ?= https://127.0.0.1:9297
CA_BUNDLE ?= $(HOME)/.aws/emulator/9297/ca.pem
TF_DIR ?= terraform
TF = terraform -chdir=$(TF_DIR)

emulator:
	docker build -t aws-emulator .
	docker run --rm -p 9297:9297 aws-emulator -a off

init:
	$(TF) init

plan:
	$(TF) plan

apply:
	$(TF) apply -auto-approve

destroy:
	$(TF) destroy -auto-approve

fmt:
	$(TF) fmt -recursive

validate:
	$(TF) validate

health:
	curl -sk $(ENDPOINT)/__admin/health && echo

reset-state:
	rm -f $(TF_DIR)/terraform.tfstate $(TF_DIR)/terraform.tfstate.backup

clean:
	rm -rf $(TF_DIR)/build $(TF_DIR)/.terraform
