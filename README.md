# AWS EC2 Instance Metadata Retrieval Script

## Description
This Bash script fetches metadata for a given AWS EC2 instance in JSON format. It follows the official [AWS documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html#query-IMDS-existing-instances) to ensure accurate retrieval.

## Prerequisites
- [AWS CLI installed and configured](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
  - The following environment variables are available in the shell context:
    - AWS_PROFILE
    - AWS_REGION
- Necessary IAM permissions to query instance metadata  
- Bash environment
- [JQ installed and available in terminal](https://jqlang.org/download/)

## Usage
Run the script with the following command:

```bash
./queryInstance.sh <INSTANCE_ID> <optional:DATA_KEY>
```
For help run:
```bash
./queryInstance.sh -h|--help
```

#### Example 1: Choosing a particular data key
```bash
./queryInstance.sh i-0xxxxxxxxxxxx MetadataOptions

# Output
---------------------------------------------------

{
  "MetadataOptions": {
    "State": "applied",
    "HttpTokens": "required",
    "HttpPutResponseHopLimit": 2,
    "HttpEndpoint": "enabled",
    "HttpProtocolIpv6": "disabled",
    "InstanceMetadataTags": "disabled"
  }
}

---------------------------------------------------
```

#### Example 2: Get all metadata key
```bash
./queryInstance.sh i-0xxxxxxxxxxxx

# Output
---------------------------------------------------
[
    {
        "Architecture": "x86_64",
        "BlockDeviceMappings": [
            {
                "DeviceName": "/dev/sda1",
                "Ebs": {
                    "AttachTime": "2025-05-04T13:06:48+00:00",
                    "DeleteOnTermination": true,
                    "Status": "attached",
                    "VolumeId": "vol-0094f54c39b917ce7"
                }
            }
        ],
        "ClientToken": "3727fd4a-48a9-451a-a442-cda0dc9d255b",
        "EbsOptimized": true,
        "EnaSupport": true,
        "Hypervisor": "xen",
        "NetworkInterfaces": [
            {
                "Attachment": {
                    "AttachTime": "2025-05-04T13:06:48+00:00",
                    "AttachmentId": "eni-attach-0718fb8a654f1bd37",
                    "DeleteOnTermination": true,
                    "DeviceIndex": 0,
                    "Status": "attached",
                    "NetworkCardIndex": 0
                },
                "Description": "",
                "Groups": [
                    {
                        "GroupId": "sg-027592eee031227a9",
                        "GroupName": "launch-wizard-2"
                    }
                ],
                "Ipv6Addresses": [],
                "MacAddress": "06:7a:82:28:57:51",
                "NetworkInterfaceId": "eni-09843a1374cb58c48",
                "OwnerId": "507266251482",
                "PrivateDnsName": "ip-10-0-101-79.eu-west-2.compute.internal",
                "PrivateIpAddress": "10.0.101.79",
                "PrivateIpAddresses": [
                    {
                        "Primary": true,
                        "PrivateDnsName": "ip-10-0-101-79.eu-west-2.compute.internal",
                        "PrivateIpAddress": "10.0.101.79"
                    }
                ],
                "SourceDestCheck": true,
                "Status": "in-use",
                "SubnetId": "subnet-0a1d9bf9cea0438e8",
                "VpcId": "vpc-0a2bdb1b9b70b5ae8",
                "InterfaceType": "interface",
                "Operator": {
                    "Managed": false
                }
            }
        ],
        "RootDeviceName": "/dev/sda1",
        "RootDeviceType": "ebs",
        "SecurityGroups": [
            {
                "GroupId": "sg-027592eee031227a9",
                "GroupName": "launch-wizard-2"
            }
        ],
        "SourceDestCheck": true,
        "StateReason": {
            "Code": "Client.UserInitiatedShutdown",
            "Message": "Client.UserInitiatedShutdown: User initiated shutdown"
        },
        "Tags": [
            {
                "Key": "Name",
                "Value": "windowstest"
            }
        ],
        "VirtualizationType": "hvm",
        "CpuOptions": {
            "CoreCount": 1,
            "ThreadsPerCore": 2
        },
        "CapacityReservationSpecification": {
            "CapacityReservationPreference": "open"
        },
        "HibernationOptions": {
            "Configured": false
        },
        "MetadataOptions": {
            "State": "applied",
            "HttpTokens": "required",
            "HttpPutResponseHopLimit": 2,
            "HttpEndpoint": "enabled",
            "HttpProtocolIpv6": "disabled",
            "InstanceMetadataTags": "disabled"
        },
        "EnclaveOptions": {
            "Enabled": false
        },
        "BootMode": "uefi",
        "PlatformDetails": "Windows",
        "UsageOperation": "RunInstances:0002",
        "UsageOperationUpdateTime": "2025-05-04T13:06:48+00:00",
        "PrivateDnsNameOptions": {
            "HostnameType": "ip-name",
            "EnableResourceNameDnsARecord": false,
            "EnableResourceNameDnsAAAARecord": false
        },
        "MaintenanceOptions": {
            "AutoRecovery": "default"
        },
        "CurrentInstanceBootMode": "uefi",
        "NetworkPerformanceOptions": {
            "BandwidthWeighting": "default"
        },
        "Operator": {
            "Managed": false
        },
        "InstanceId": "i-0f8d09acbfab5ca22",
        "ImageId": "ami-033325ee9cd18c7d8",
        "State": {
            "Code": 80,
            "Name": "stopped"
        },
        "PrivateDnsName": "ip-10-0-101-79.eu-west-2.compute.internal",
        "PublicDnsName": "",
        "StateTransitionReason": "User initiated (2025-05-04 13:27:10 GMT)",
        "KeyName": "challeng",
        "AmiLaunchIndex": 0,
        "ProductCodes": [],
        "InstanceType": "t3.nano",
        "LaunchTime": "2025-05-04T13:06:48+00:00",
        "Placement": {
            "GroupName": "",
            "Tenancy": "default",
            "AvailabilityZone": "eu-west-2a"
        },
        "Platform": "windows",
        "Monitoring": {
            "State": "disabled"
        },
        "SubnetId": "subnet-0a1d9bf9cea0438e8",
        "VpcId": "vpc-0a2bdb1b9b70b5ae8",
        "PrivateIpAddress": "10.0.101.79"
    }
]
---------------------------------------------------

```

## References
For additional details, refer to the [AWS EC2 Instance Metadata Guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html).