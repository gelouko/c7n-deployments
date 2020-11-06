# Centralized Cloud Custodian Deployment

This is a multi-account architecture for real-time compliance with Cloud Custodian.

It deploys the policy lambdas inside a single account and uses other accounts' events to detect/act on uncompliant resources.

## Architecture:

https://app.cloudcraft.co/view/3bffe4cf-f17a-4907-973b-b0ae1bd98d16?key=96XwyeACP5v6v8Gx6VWfww

## Blog post about this architecture:

In this blog post the architecture is explained and it also has some example usage.

It also talks about some basic costs and limits that this architecture has.

Check it in here: https://gelouko.ninja

Note that this is a minimal architecture and in the blog, I'm using a full-blown policy with KMS encryption and an S3 bucket for logs, so if you want to execute that policy, you'll need more infrastructure/permissions.

A policy that can be easily run with this minimal deployment is:


```yaml
policies:
  - name: delete-s3-buckets
    resource: s3
    mode:
      type: cloudtrail
      role: CustodianLambdaExecutionRole
      member-role: arn:aws:iam::{account_id}:role/CloudCustodianCrossAccountRole
      memory: 128
      timeout: 30
      events:
        - CreateBucket
    filters:
      - type: bucket-logging
        op: disabled
    actions:
      - delete
```

## Intallation

To install this architecture in your AWS Organization, you just have to run `terraform apply` in these 2 terraform templates:

[The Cloud Custodian Account Template](/gelouko/c7n-deployments/tree/master/centralized-arch/cloud-custodian-account-template)

[The Developer Account Template](/gelouko/c7n-deployments/tree/master/centralized-arch/developer-account-template)

### Cloud Custodian Account Template

This template adds the necessary infrastructure in a centralized account (roles, etc.) to enable Cloud Custodian deployments.

### Developer Account Template

This template will add the necessary cross-account roles and EventBridge forwarder rules to make the architecture work.

> It is also a good idea to have some kind of denial for your users to delete/modify these roles/rules.

### Organization CloudTrail Trail

Note that you need a CloudTrail Trail activated in the developer accounts to make the Amazon EventBridge integration work with management API calls.

As a best practice, you should have an Organization Trail that is enabled for your whole organization in all the regions you need, so I won't be covering that in the templates.

## Important notes

- Currently, terraform [does not support DLQ and retry policies for EventBridge targets](https://github.com/hashicorp/terraform-provider-aws/issues/15836), so you have to manually set the DLQ configuration.
- Note that you might need extra infrastructure/permissions if you want to use S3 buckets for logging, KMS keys for encryption, etc. For now, I've just added the minimal infrastructure needed to deploy a working guardrail!
