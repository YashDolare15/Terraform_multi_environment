# AWS Infrastructure Provisioning with Terraform

This README documents **only the Terraform part** of the AWS DevOps project: where to open the terminal, how to locate the Terraform configuration, which commands to run, and what to verify after each command.

## Project configuration

| Item | Value |
|---|---|
| GitHub repository | `https://github.com/YashDolare15/aws-devops-automation` |
| AWS Region used by the project | `us-east-1` |
| EKS cluster name referenced in this project | `AWSCluster` |
| RDS database name referenced in this project | `task_tracker` |

> The exact AWS resources created by Terraform depend on the `.tf` configuration files in the repository. Follow the configuration and outputs in your own checkout; do not assume a resource exists unless Terraform or the AWS Console confirms it.

---

## Step 1 — Open PowerShell and clone the repository

**Where to go:** On your Windows computer, open **Windows PowerShell** or open VS Code and select **Terminal → New Terminal**.

Choose a folder where you want to save the project. For example:

```powershell
cd D:\Projects
```

Clone the repository and enter the project directory:

```powershell
git clone https://github.com/YashDolare15/aws-devops-automation.git
cd aws-devops-automation
```

If you already cloned the repository, do not clone it again. Use `cd` to enter the existing folder.

Check that the repository opened correctly:

```powershell
git status
Get-ChildItem
```

**What to check:** `git status` shows the current branch and working-tree status. `Get-ChildItem` lists the files and folders.

---

## Step 2 — Find the Terraform configuration directory

**Where to type:** In the same PowerShell terminal, from the repository root.

Run:

```powershell
Get-ChildItem -Recurse -Include *.tf
```

This lists the Terraform files in the repository. Find the directory containing the configuration you want to deploy. It may contain files such as `main.tf`, `variables.tf`, `outputs.tf`, or module folders.

Move to that actual directory:

```powershell
cd <terraform-folder-path>
Get-ChildItem
```

Replace `<terraform-folder-path>` with the real path shown on your computer; do not type the angle brackets literally.

**What to check:** The current directory should contain the Terraform root configuration files. Run `Get-Location` to confirm where you are:

```powershell
Get-Location
```

If the project uses separate Terraform root folders for different environments, run the commands below in the folder for the environment you intend to provision.

---

## Step 3 — Check Terraform and AWS CLI prerequisites

**Where to type:** In PowerShell, while in the Terraform configuration directory.

Check Terraform is installed:

```powershell
terraform -version
```

Check the AWS CLI is installed:

```powershell
aws --version
```

If either command is not recognized, install the missing tool and reopen PowerShell before continuing.

Confirm the AWS identity and account you intend to use:

```powershell
aws sts get-caller-identity
```

If your local AWS CLI is not configured, configure an approved authentication method before continuing. Do not put AWS access keys in source code or commit them to GitHub.

Set/check the intended AWS Region for this project:

```powershell
$env:AWS_DEFAULT_REGION = "us-east-1"
aws configure get region
```

The environment variable applies to the current PowerShell session. The `aws configure get region` command displays the CLI's configured default region, which may be different.

---

## Step 4 — Initialize Terraform

**Where to type:** Still in the Terraform root directory containing the `.tf` files.

Run:

```powershell
terraform init
```

**What this does:** Initializes the working directory and downloads the required Terraform providers and any configured modules.

**What to check:** The command finishes successfully and reports that Terraform has been initialized. If it fails, check the error message, network access, provider requirements, and any configured backend.

---

## Step 5 — Validate the Terraform configuration

Run:

```powershell
terraform validate
```

**What this does:** Checks the configuration for syntax and internal consistency.

**What to check:** Terraform reports that the configuration is valid. If validation fails, correct the indicated `.tf` file before moving forward.

---

## Step 6 — Review variables and environment values

Before planning, inspect the configuration for required variables. In PowerShell, list variable files:

```powershell
Get-ChildItem -Recurse -Include terraform.tfvars,*.auto.tfvars
```

Review the variable declarations and any example `.tfvars` file included in the repository. Supply the values required by this project using its documented method.

**Important:**
- Do not guess variable values.
- Do not commit passwords, tokens, private keys, or other secrets in `.tfvars`.
- If the project uses a remote state backend, make sure you are using the intended backend and environment.
- If the project has separate environment folders, work in the correct one.

---

## Step 7 — Create and review a Terraform plan

Run:

```powershell
terraform plan
```

Terraform compares the desired configuration with the current state and proposes changes.

**Before applying, review the plan carefully:**
- Confirm the AWS account and Region are correct.
- Check which resources will be created, updated, or destroyed.
- Stop if the plan proposes unexpected deletions or changes.
- Confirm any costs and quotas relevant to the resources being provisioned.

Do not apply a plan you do not understand.

---

## Step 8 — Apply the Terraform configuration

When the plan is correct, run:

```powershell
terraform apply
```

Terraform displays the planned changes and asks for confirmation. Type:

```text
yes
```

only if the plan is correct and you intend to create or change those resources.

**What to do next:** Wait for Terraform to finish. Check the final output for errors and note any resource identifiers or outputs it prints.

> Do not run `terraform destroy` as part of deployment. That command can remove the infrastructure.

---

## Step 9 — Check Terraform outputs and state

After a successful apply, inspect the outputs defined by the configuration:

```powershell
terraform output
```

If there are no outputs defined, Terraform may report that no outputs are available. This does not by itself mean the apply failed.

Check the Terraform state summary:

```powershell
terraform state list
```

This lists resources tracked in the current state. Treat Terraform state as sensitive: it can contain secrets or infrastructure details. Do not upload or share `terraform.tfstate` publicly.

---

## Step 10 — Verify the AWS resources in the Console

**Where to go:**

1. Open the [AWS Management Console](https://console.aws.amazon.com/).
2. Sign in to the AWS account used for Terraform.
3. Set the Region selector to **US East (N. Virginia) — `us-east-1`**.
4. Open the service pages corresponding to the resources defined in the Terraform configuration.

For the known resources referenced in this project:

### Verify EKS

1. Search for **EKS** in the AWS Console.
2. Open **Amazon Elastic Kubernetes Service → Clusters**.
3. Locate `AWSCluster`.
4. If Terraform created or manages this cluster, confirm its status is **Active**.
5. Check the cluster's compute/node-group area and confirm the worker nodes are healthy.

### Verify RDS

1. Search for **RDS**.
2. Open **Amazon RDS → Databases**.
3. Locate the database instance configured by the project.
4. Check that its status is available and confirm the expected database configuration, including `task_tracker` where applicable.

The cluster and database names above are known project references; verify that they match the resources actually managed by the Terraform configuration.

---

## Step 11 — Troubleshooting

| Problem | What to check |
|---|---|
| `terraform` is not recognized | Install Terraform, check the system `PATH`, and reopen PowerShell |
| `aws` is not recognized | Install AWS CLI and reopen PowerShell |
| `aws sts get-caller-identity` fails | Check the configured AWS authentication method and permissions |
| `terraform init` fails | Check provider requirements, backend configuration, and network access |
| `terraform validate` fails | Read the file and line identified by the error; correct the configuration |
| `terraform plan` asks for missing values | Review required variables and the project's documented variable inputs |
| `terraform apply` fails with access denied | Check the identity returned by STS and the permissions required by the resources |
| A resource already exists | Inspect the plan and existing resource/state carefully; do not delete resources blindly |
| The wrong Region appears | Confirm the AWS provider's `region` setting and the intended CLI/environment settings |
| State/backend error appears | Confirm you are using the correct backend and workspace/environment |

---

## Final Terraform checklist

- [ ] Opened PowerShell or the VS Code terminal.
- [ ] Cloned the correct GitHub repository or entered the existing checkout.
- [ ] Located the correct Terraform root directory.
- [ ] Confirmed Terraform and AWS CLI are installed.
- [ ] Confirmed the intended AWS identity and Region.
- [ ] Ran `terraform init` successfully.
- [ ] Ran `terraform validate` successfully.
- [ ] Supplied the required project variables securely.
- [ ] Reviewed `terraform plan`.
- [ ] Approved and completed `terraform apply`.
- [ ] Checked `terraform output` and `terraform state list`.
- [ ] Verified the resources in the AWS Console.
- [ ] Kept Terraform state and credentials private.
