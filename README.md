Project - Septa Stream
==============================

Description
===========
Create an S3 bucket configured for static website hosting. When a new file is uploaded to the S3 bucket, it triggers an event in the EventBridge service, which is sent to Step Functions. This triggers an AWS Lambda process that returns the details of the new file uploaded.

Architecture
============
<img width="400" height="400" alt="imagen" src="https://github.com/user-attachments/assets/5b2193a4-9ec1-477d-8727-a05229e942ff" />

Tools used
===========
- Terraform
- GitHub Actions
- Terraform Cloud

