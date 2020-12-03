PLANFILE="tfplan"
TERRAFORM=terraform

.phony: plan
plan: fmt
	@$(TERRAFORM) plan -out $(PLANFILE)

.phony: apply
apply:
	@$(TERRAFORM) apply $(PLANFILE)
	@rm $(PLANFILE)

.phony: fmt
fmt:
	@$(TERRAFORM) fmt
