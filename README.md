Project - Septa Stream
==============================

Description
===========
Create an S3 bucket working as static website hosting. When S3 upload a new file in the bucket, it triggers an event in Eventbridge service that is send to Step Functions, who trigger an AWS Lambda process and return the details of the new file uploaded.

Architecture
============
<img width="400" height="400" alt="imagen" src="https://github.com/user-attachments/assets/5b2193a4-9ec1-477d-8727-a05229e942ff" />

Tools used
===========
- Terraform
- GitHub Actions
- Terraform Cloud

