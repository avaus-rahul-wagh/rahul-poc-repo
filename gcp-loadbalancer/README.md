
```bash
gcloud auth application-default login --project rahul-sandbox-374309
```

Set Quota project 

```bash
gcloud auth application-default set-quota-project rahul-sandbox-374309 
```

```bash
terraform init --var-file="terraform-dev.tfvars"  -reconfigure
terraform plan --var-file="terraform-dev.tfvars"
terraform apply --var-file="terraform-dev.tfvars"
```