#!/bin/bash

npx netlify deploy >deploy.log
export DEPLOY_URL=$(cat deploy.log | awk -F"[ ]+" '/Website Draft URL:/{print $4}')
# Remove ANSI colours from the URL
export DEPLOY_MESSAGE="🚀 Deployed a preview app to: $(echo ${DEPLOY_URL} | sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g')"

echo ${DEPLOY_MESSAGE}
if [ -z ${CIRCLE_PR_NUMBER+x} ]; then
    gh pr comment --body ${DEPLOY_MESSAGE}
fi
