#!/bin/bash

if [ -z ${CIRCLE_PR_NUMBER+x} ]; then
    export DEPLOY_ALIAS=$(git rev-parse --short HEAD)
else
    export DEPLOY_ALIAS="pr-$CIRCLE_PR_NUMBER"
fi

npx netlify deploy --alias ${DEPLOY_ALIAS} >deploy.log

# Extract the deploy URL from the netlify output
export DEPLOY_URL=$(cat deploy.log | awk -F"[ ]+" '/Website Draft URL:/{print $4}')
# Remove ANSI colours from the URL
export DEPLOY_MESSAGE="🚀 Deployed a preview app to: $(echo ${DEPLOY_URL} | sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g')"

echo "${DEPLOY_MESSAGE}"
if [ ! -z ${CIRCLE_PULL_REQUEST+x} ]; then
    echo "Posting a github comment to the pull request..."
    gh pr comment --body "${DEPLOY_MESSAGE}"
fi
