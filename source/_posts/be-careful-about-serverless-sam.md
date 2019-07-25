---
layout: title
title: Be careful about serverless - SAM
date: 2019-07-20 11:49:27
tags: serverless
categories: Tech
---

## intro
Recently I am doing some work related to serverless. I am working on a service developed with full AWS stack. We use cloudfront and S3 for our CDN and static storage. At most case, our service is executed call-as-we-need, but still with high-throughput. At the very first beginning, using AWS lambda and API Gateway seems a reasonable choice. Low cost, easy to maintain. And we got the previous SAM (serverless application model) experience. We using CloudFormation [Macro](https://docs.aws.amazon.com/zh_cn/AWSCloudFormation/latest/UserGuide/template-macros.html) to make template more easier to use, reduce the coding work. But the Macro is uncontrollable, we can not debug the Macro when we come up with trouble. 

Here comes the problem.

## Bug with Dynamodb 
We defined a certain number of DynamoDB table on the CloudFormation, and another CloudFormation stack the refer those content in the table. The official way is define some Output in the table template, the export those attributed (e.g. ARN) from DynamoDB. 

The Stack will refer those content using ImportValue. However, after we update the stack add those Output, it will throw out internal error. 

We send a ticket to AWS and the AWS engineer adjust our stack, which we only got only one DynamoDB to add Output. 

But what about other DynamoDB table, we needs to add those ARN manually. That wasn't elegant. But it works. 

## But with API Gateway
When we using API Gateway, we need to redeploy it again when we update the config. In Cloudformation, Deployment is needed for API Gateway. We did the same with Macros. It works will when we using Macros to auto create that resources and auto deploy. But when We were invoking lambda via the API Gateway created by Macros. We found out that the request wasn't even reach to the lambda. It just return 502 directly by API Gateway. d

We check the log and got the error: Premission error. It means that the API Gateway didn't have the premission to access the lambda. Then we trace the stack to the upper resource. It seems the API Gateway was trying to invoke a lambda which even wasn't create by our currecy stack. 

Then it might be Deployment was unavilable. We send a ticket and be told that it was a expected result. Because the LogicalID in the template wasn't changed, then it would not trigger the Deplyment. But still not good the change LogicalID when we auto deploy using Macros. 

## Grammer check
This may not be a bug but still shows us that SAM might not be  a good choice on production. Cloudformation owns a template verify tool, its only check the yaml and json grammer. But not for the AWS template grammer check. This may cause our developer write the wrong template few times. There is a AWS open source called `cfn-python-lint`. But that stuff did not works well or even actually not working. 

## Solution
That problems shows above might just be a unfriendly usage of Cloudformation. We are actually working on it. Like I thinks before, DynamoDB's lifecycle is different with lambda, we need to decouple those module. `Changeset` might be a recommendation. 

Everytime we publish a lambda, we are update the $LATEST version of lambda. The API is calling the latest version by default. That means the function code is dynamical. And the deployment is snapshot of restapi, its static. But I believed that AWS::Lambda::Version is constrained a particular lambda usage. then we reference that api in the particular version. 

The Macro might be redundent for our exists workflow, we hope it can tidy up our ops stuff, but it working on the opposite. 

The only way to verfiy the Cloudformation template is put our stack on a sandbox. But that was overcosting for time. A single deployment on cloudfront may cost over half-hours. Anyway, drop the Macro or use a more native way may helps us. 

Again, it's necessay to split up our stack. The infra network layer, data layer and app needs to put on different stacks. 