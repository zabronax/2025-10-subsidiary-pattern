# Subsidiary Pattern Project Tasks

repo-root := `git rev-parse --show-toplevel`

[doc("Default recipe - show available tasks")]
default:
    @just --list --unsorted --list-heading $'Project Task:\n'

# ====================
# = Helper Functions =
# ====================

[doc("Helper function to run an action in each directory")]
_in-each-directory action +directories:
    @for dir in {{directories}}; \
    do \
        cd "{{repo-root}}/$dir"; \
        {{action}}; \
    done

# ==========================
# = Infrastructure as Code =
# ==========================

# Infrastructure as Code project directories
iac-projects := "domains/larsgunnar.no domains/kodehode.larsgunnar.no project test-infra/server test-infra/web-app"

[group("IaC")]
[doc("Format HCL files across all IaC directories")]
iac-format:
    @just _in-each-directory "tofu fmt -recursive" {{iac-projects}}

[group("IaC")]
[doc("Check HCL formatting across all IaC directories")]
iac-format-check:
    @just _in-each-directory "tofu fmt -check -recursive" {{iac-projects}}

[group("IaC")]
[doc("Initialize OpenTofu providers in all IaC directories")]
iac-init:
    @just _in-each-directory "tofu init -backend=false -lockfile=readonly" {{iac-projects}}

[group("IaC")]
[doc("Validate Terraform configuration in all IaC directories")]
iac-validate:
    @just _in-each-directory "tofu validate" {{iac-projects}}


# ===================
# = Secret Handling =
# ===================

[doc("Helper function to run an action on each secret file")]
_for-each-secret-file action:
    find .                              \
        -name "secrets.yaml"            \
        -type f -print0                 \
    | while IFS= read -r -d '' file; do \
        {{action}} "$file"; \
    done

[group("Secrets")]
[doc("Update keys for all secrets files")]
secrets-update-keys:
    @just _for-each-secret-file "sops updatekeys --yes --input-type yaml"

[group("Secrets")]
[doc("Rotate DEK (Data Encryption Keys) for all secrets files")]
secrets-rotate-dek:
    @just _for-each-secret-file "sops updatekeys --yes --input-type yaml --rotate"
