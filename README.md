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
- [JQ is installed and available in terminal](https://jqlang.org/download/)

## Usage
Run the script with the following command:

```bash
./queryInstance.sh <INSTANCE_ID> [METADATA]
```

## References
For additional details, refer to the [AWS EC2 Instance Metadata Guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html).