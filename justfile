# Subsidiary Pattern Project Tasks

repo-root := `git rev-parse --show-toplevel`

# Infrastructure as Code project directories
iac-projects := "domains/larsgunnar.no domains/kodehode.larsgunnar.no project test-infra/server test-infra/web-app"

[doc("Default recipe - show available tasks")]
default:
    @just --list --unsorted --list-heading $'Project Task:\n'

[doc("Helper function to run an action in each directory")]
_for-each-directory action +directories:
    @for dir in {{directories}}; \
    do \
        cd "{{repo-root}}/$dir"; \
        {{action}}; \
    done

[group("IaC")]
[doc("Format HCL files across all IaC directories")]
iac-format:
    @just _for-each-directory "tofu fmt -recursive" {{iac-projects}}

[group("IaC")]
[doc("Check HCL formatting across all IaC directories")]
iac-format-check:
    @just _for-each-directory "tofu fmt -check -recursive" {{iac-projects}}

[group("IaC")]
[doc("Initialize OpenTofu providers in all IaC directories")]
iac-init:
    @just _for-each-directory "tofu init -lockfile=readonly" {{iac-projects}}

[group("IaC")]
[doc("Validate Terraform configuration in all IaC directories")]
iac-validate:
    @just _for-each-directory "tofu validate" {{iac-projects}}

