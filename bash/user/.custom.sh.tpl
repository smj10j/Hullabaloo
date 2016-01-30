#!/bin/bash

# Convenient directory navigation
alias smj='cd /Code/smj10j/'


# Tail a file using a buffer (`less` may be preferred to using this)
alias bfol='stdbuf -o10K tail -f'


# Security Group Management
# aws-sg-ls() {
#     aws --profile=extrabux ec2 describe-security-groups --query='*[].[GroupName,GroupId,IpPermissions]'
# }
# aws-sg-mod() {
#     if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ] || [ -z "$5" ]; then
#         echo "Usage: aws-sg-mod sg-group-id protocol from-port to-port cidr-ip"
#         return
#     fi
#     aws --profile=extrabux ec2 authorize-security-group-ingress --group-id=sg-$1 --ip-permissions \
#     '[{"IpProtocol": "$2", "FromPort": $3, "ToPort": $4, "IpRanges": [{"CidrIp": "$5"}]}]'
# }
