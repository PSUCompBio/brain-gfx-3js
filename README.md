# brain-gfx-3js

# AWS Install on ElasticBeanStalk

Locally from within directory you want to zip up imporant files.
Be sure to change the 19 to the latest number

'> zip -r clinicalimgv1-source-19.zip .npmrc server.js package.json config'

Then upload the zip file to elasticbeanstalk.

# Local Install

## To install

npm install

## To test

node test.js
Should create a example.png

# Instruction on Lambda use.

1. create ec2 instance. Use the bash script which runs the Dockerfile
2. once image is built push the docker to elastic container registry (ECR)
3. Update lambda ?

### from ec2 instance used to build docker image

sudo \$(aws ecr get-login --region us-east-1 --no-include-email)
sudo docker push <AWS-Account-ID>.dkr.ecr.us-east-1.amazonaws.com/clinicalimg
