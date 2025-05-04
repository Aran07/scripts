#!/bin/bash

# This script fetches the specified EC2 metadata for a given instance ID in JSON format.
# It follows the example outlined in AWS documentation(https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html#query-IMDS-existing-instances) for retrieving instance metadata.

# Exit the script if any of the commands in the script fails
set -e

# Variables
FILTER=true

# Validate script input
useage() {
    echo "Useage: $0 INSTANCE_ID [METADATA]"
    echo ""
    echo "Arguments:"
    echo " INSTANCE_ID  The instance id"
    echo " METADATA     (optional) Specific data key to be returned (default: all)"
    exit 1
}

if [ "$1" = "-h" ] || [ "$1" = "--help" ] || [ -z "$1" ]; then
  useage
fi

INSTANCE_ID="$1"
METADATA="$2"

# Check whether filtering  is required
if [ -z "$METADATA" ]; then
   FILTER=false
fi

# Check if AWS CLI is installed on machine
if [ ! command -v aws &> /dev/null ]; then
    echo "Error: aws cli is required but not installed!"
    echo "Install aws cli and try again. Here is a helpful guide https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html."
    exit 1;
fi

# Check if jq is installed on machine
if [ ! command -v jq &> /dev/null ]; then
    echo "Error: aws cli is required but not installed!"
    echo "Install aws cli and try again. Here is a helpful guide https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html."
    exit 1;
fi

# Validate required aws environment variables are set
if [ -z "$AWS_PROFILE" ] || [ -z "$AWS_REGION" ]; then
  echo "Error: This script expects AWS_PROFILE and AWS_REGION environment variables to be set."
  echo "Please set these using the following commands and try again."
  echo " export AWS_PROFILE=<value>"
  echo " export AWS_REGION=<value>"
  exit 1;
fi

# Check if aws credentials are configured
if ! aws sts get-caller-identity &> /dev/null ; then
  echo " Error: User aws credentials not found locally."
  echo " Please configure valid credentials and try again. If you need help have a look at https://docs.aws.amazon.com/cli/v1/userguide/cli-chap-configure.html."
  exit 1;
fi

# Check if instance exists
INSTANCE_AVAILABLE=$(aws ec2 describe-instances --instance-id $INSTANCE_ID --query 'Reservations[*].Instances[*].InstanceId' --no-cli-pager --output text)
if [ -z $INSTANCE_AVAILABLE ]; then
  LIST_ALL_INSTANCES=$(aws ec2 describe-instances --no-cli-pager --output text --query 'Reservations[*].Instances[*].InstanceId')
  echo "Unable to find instance $INSTANCE_ID."
  echo
  echo "Here is a list of instances found: "
  echo $LIST_ALL_INSTANCES
  echo
  echo "Please try again with one of the above instances."
  exit 0;
else
  echo "Instance $INSTANCE_ID located." 
  echo "Fetching requested instance detail...."
fi

# Get Requested information"
INSTANCE_DETAIL=$(aws ec2 describe-instances --instance-id $INSTANCE_ID --no-cli-pager --output json --query 'Reservations[*].Instances[]')
if [ -z $INSTANCE_DETAIL ]; then
  echo "Error: Unable to fetch instance detail for $INSTANCE_DETAIL"
fi

if [ "$FILTER" == "true" ]; then
  echo "Filtering output as requested...."
  OUTPUT=$(echo "${INSTANCE_DETAIL}" | jq ".. | objects | with_entries(select(.key==\"${METADATA}\")) | select(. != {})")
  echo "Returning key: ${METADATA}"
  echo 
  echo "---------------------------------------------------"
  echo
  echo "${OUTPUT}"
  echo
  echo "---------------------------------------------------"
else
  echo "Instance Metadata: "
  echo "---------------------------------------------------"
  echo
  echo "${INSTANCE_DETAIL}"
  echo
  echo "---------------------------------------------------"
fi
