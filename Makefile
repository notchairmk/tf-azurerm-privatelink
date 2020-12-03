PLANFILE="tfplan"
TERRAFORM=terraform
BACKEND_TFVARS="backend.tfvars"

.phony: plan
plan: fmt init
	@$(TERRAFORM) plan -out $(PLANFILE)

.phony: apply
apply:
	@$(TERRAFORM) apply $(PLANFILE)
	@rm $(PLANFILE)

.phony: fmt
fmt:
	@$(TERRAFORM) fmt

.phony: init
init:
	@$(TERRAFORM) init -backend-config=$(BACKEND_TFVARS)
