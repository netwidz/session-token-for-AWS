#!/bin/bash

TOKEN_CODE=$1
SERIAL_ARN=arn:aws:iam::570551521311:mfa/FahizFairoseKhan
ROLE_SESSION_NAME=testing
DURATION=3600
ASSUME_ROLE_ARN=arn:aws:iam::563502482979:role/admin

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN

aws sts get-session-token --serial-number $SERIAL_ARN --token-code $TOKEN_CODE --profile MOJ > response.json

#$(echo $SESSION_TOKEN) > response.json
#echo $SESSION_TOKEN

export AWS_SECRET_ACCESS_KEY=$(jq -r '.Credentials.SecretAccessKey' response.json)
export AWS_ACCESS_KEY_ID=$(jq -r '.Credentials.AccessKeyId' response.json)
export AWS_SESSION_TOKEN=$(jq -r '.Credentials.SessionToken' response.json)

echo "\n\n ==========USER SESSION KEYS===================\n\n"

echo "AWS_SECRET_ACCESS_KEY : $AWS_SECRET_ACCESS_KEY"
echo "AWS_ACCESS_KEY_ID : $AWS_ACCESS_KEY_ID"
echo "AWS_SESSION_TOKEN : $AWS_SESSION_TOKEN"
echo "\n\n ==========Assuming Role===================\n\n"

aws sts assume-role --role-arn $ASSUME_ROLE_ARN --role-session-name $ROLE_SESSION_NAME --duration-seconds $DURATION > assumerole.json

echo "\n\n ==========ASSUME ROLE KEYS===================\n\n"

echo "AWS_SECRET_ACCESS_KEY : $(jq -r '.Credentials.SecretAccessKey' assumerole.json)"
echo "AWS_ACCESS_KEY_ID : $(jq -r '.Credentials.AccessKeyId' assumerole.json)"
echo "AWS_SESSION_TOKEN : $(jq -r '.Credentials.SessionToken' assumerole.json)"
