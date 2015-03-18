#! /bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SHA1=$1
if [ -z $SHA1 ]; then
  SHA1='latest'
fi
EB_BUCKET=datafit

# Create new Elastic Beanstalk version
DOCKERRUN_FILE=$SHA1-Dockerrun.aws.json
sed "s/<TAG>/$SHA1/" < $DIR/Dockerrun.aws.json.template > $DIR/$DOCKERRUN_FILE
aws s3 cp $DIR/$DOCKERRUN_FILE s3://$EB_BUCKET/build/$DOCKERRUN_FILE
aws elasticbeanstalk --region us-east-1 create-application-version --application-name researchURL \
    --version-label $SHA1 --source-bundle S3Bucket=$EB_BUCKET,S3Key=build/$DOCKERRUN_FILE

# Update Elastic Beanstalk environment to new version
aws elasticbeanstalk --region us-east-1 update-environment --environment-name researchURL-env --version-label $SHA1