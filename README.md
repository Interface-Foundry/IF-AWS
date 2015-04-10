#AWS Infrastructure deployment code.

##Prerequisites:

###IAM Policies.

The elasticsearch nodes need a specific IAM role to allow the ec2 discovery plugin to work

```
{
    "Statement": [
        {
            "Action": [
                "ec2:DescribeInstances"
            ],
            "Effect": "Allow",
            "Resource": [
                "*"
            ]
        }
    ],
    "Version": "2012-10-17"
}
```

The code deploy AWS frontend needs to policies to work. One called CodeDeploy-InstanceRole, applied to the instances, and one called CodeDeploy-ServiceRole, applied to the CodeDeploy frontend.

CodeDeploy-ServiceRole:

```
{"Version": "2012-10-17",
 
"Statement": [
 
   {
 
     "Action": [
 
       "autoscaling:PutLifecycleHook",
 
       "autoscaling:DeleteLifecycleHook",
 
       "autoscaling:RecordLifecycleActionHeartbeat",
 
       "autoscaling:CompleteLifecycleAction",
 
       "autoscaling:DescribeAutoscalingGroups",
 
       "autoscaling:PutInstanceInStandby",
 
       "autoscaling:PutInstanceInService",
 
       "ec2:Describe*"
 
     ],
 
     "Effect": "Allow",
 
     "Resource": "*"
 
   }
 
]
 
}
```

CodeDeploy-InstanceRole:

```
{ 
    "Version": "2012-10-17", 
    "Statement": [   
    {     
        "Action": [       
            "s3:Get*",       
            "s3:List*"     
        ],     
        "Effect": "Allow",     
        "Resource": "*"   
    } 
    ]
}
```

###IAM SSL certificates

The SSL certificate must be uploaded in IAM prior to launching the web-server stack.

## Usage

In each one of these templates you should have a terraform.tfvars file which looks like this:

```
access_key = "XXXXXXXXXXXXXXXXXX"
secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXX"
key_name = "MyKeyPair"
key_path = "/somepath/MyKeyPair.pem"
```
