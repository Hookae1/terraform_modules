# Terraform module creates AWS CodePipeline to Build and Deploy React App to S3 bucket

## Dependencices

Additional resources must be create before begin

* AWS S3 bucket configured for webhosting
* AWS S3 bucket with env files (private)
* GitHub resources (Organisation/Username, Repository, OAuth token, Branch to build, `buildspec.yml` must be included in repo root)
* AWS SNS topic (if you want to add approval step)

## Resorces

This module creates:

* AWS CodePipeline - get changes from GitHub, build and deliver it to some S3 bucket
* AWS CodeBuild - to automatialy build React App
* AWS S3 bucket - to store build results
* AWS IAM Roles and Policies to make it all working together

## Usage

Copy all to your modules directory and include module in your `main.tf`
Update `codepipeline/build.tf` according to your `buildspec.yml`
Run `terraform plan` and `terraform apply`

## Example of full configuration

```hcl
module "codepipeline" {
  source                  = "../modules/codepipeline"
  pipe_name               = "some_unique_name"           # Name to make your resources unique
  pipe_github_username    = "github_username"            # GitHub Organisation/Username
  pipe_github_token       = "github_token"               # GitHub OAuth token
  pipe_github_repo        = "github_repo"                # GitHub Repository
  pipe_github_branch      = "github_branch"              # GitHub branch to build from
  pipe_deploy_bucket      = "web_hosting_s3_bucket_name" # name of S3 bucket there app will be hosted
  pipe_env_bucket         = "env_file_s3_bucket_name"    # name of S3 bucket there env files stored (optional)
  pipe_approval_sns_topic = "approval_sns_topic_arn"     # arn of SNS topic (optional)
  pipe_project_id         = "project_id"                 # short project id
  pipe_env_id             = "env_id"                     # short env id
}
```
