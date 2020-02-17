# Session token with 2FA enabled AWS Accounts
Get session token to use in AWS CLI. 2FA enabled accounts


## Pre requicits
You need to install `jq` commandline json processor
https://stedolan.github.io/jq/

Set the following variables to generate your session keys.


```
SERIAL_ARN= set your virtual/physical 2FA device ARN
ROLE_SESSION_NAME= name your session as you prefer
DURATION=3600 - time duration the session should stay alive. in seconds
ASSUME_ROLE_ARN= ARN for assuming role
```
To run this script execute the following with your 2FA one time code as a commandline argument
```sh getSessionToken.sh 111204```
