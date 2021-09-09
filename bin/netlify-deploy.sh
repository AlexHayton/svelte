#!/bin/bash

npx netlify deploy >deploy.log
export DEPLOY_URL=$(cat deploy.log | awk -F"[ ]+" '/Website Draft URL:/{print $4}')
echo "🚀 Deployed a preview app to: ${DEPLOY_URL}"

if [ -z ${CIRCLE_PR_NUMBER+x} ]; then
    npx @humanwhocodes/github-comment alexhayton/svelte#${CIRCLE_PULL_REQUEST##*/} "🚀 Deployed a preview app to: ${DEPLOY_URL}"
fi
