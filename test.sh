#!/usr/bin/env bash

key="aws-ec2-key"
instance="nginx-server-tf"
instance_public_ip=$(aws ec2 describe-instances --filters Name=tag:Name,Values=$instance | jq -r '.Reservations[-1].Instances[-1].PublicIpAddress')

SPEC_HOST=$instance_public_ip \
SPEC_USER="ec2-user" \
SPEC_SSH_KEY="~/.ssh/$key" \
bundle exec rspec spec/nginx-server-tf