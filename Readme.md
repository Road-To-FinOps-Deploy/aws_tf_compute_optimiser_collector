# Compute optimiser collector

The purpose of this module is to collect all compute optimisation recommendations from all account in an organisation and put them into one location. This can then be queried using Athena.
It is to be deployed into the management account or any account that has access to the organisations data.

Example Queries can be found in the athena_queries folder.

## Pre-Rec
### Tecnology requirements 
* Terrdform 12
* aws cli
* profile setup on cli

### Admin requirements
* Access to Orgonisation accounts (mangment account) to deploy this in
* AWS Compute Optimizer Opt in setup for all accounts from managment account
* Athena database pre created
* Bucket for storing state file pre created

### Variable requirements
In the variables file add the following:
* cur_database
* cur_bucket
* alarm_email

## Setup
1. Install terraform 
[Terraform – Getting Started – Install Terraform on Windows, Linux and Mac OS | Vasos Koupparis](https://www.vasos-koupparis.com/terraform-getting-started-install/)

``` 
brew install terraform
```

2. Install AWS cli

[Installing the AWS CLI - AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)

```
pip3 install awscli --upgrade --user
```

3. Create an AWS IAM User
This needs to be in your **billing account**.  It will need with programtic access with the administrator policy. See AWS instructions here
[Creating Your First IAM Admin User and Group - AWS Identity and Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_create-admin-group.html)

Create using the policy in the iam.json file

Copy the Access and Secret key to your machine

4. Setup your aws profile
```
$ aws configure --profile penny
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: eu-west-1
Default output format [None]: json
```

## Deployment

``` terraform init```
``` terraform apply```


####

The purpose of this module is to collect all compute optimisation recommendations, for EC2 and Autoscaling groups, from all account in an organisation and put them into one location. This can then be queried using Athena.
It is to be deployed into the management account or any account that has access to the organisations data.
The method for this is once a month a CloudWatch event will trigger a lambda to collect all of the account ID's in the organisations. This is then passed into an SQS as individual messages. These are then passing to another lambda which will gather the AWS Compute Optimiser Recommendations for that account. This is then saved in a json format in a S3 Bucket in a partitioned setup. A crawler will then run over this data to create a partitioned Athena table which can be queried. 
