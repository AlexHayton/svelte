#!/bin/bash

netlify deploy >deploy.log
export DEPLOY_URL=$(cat deploy.log | awk -F"[ ]+" '/Website Draft URL:/{print $4}')

if [ -z ${CIRCLE_PR_NUMBER+x} ]; then
    npx @humanwhocodes/github-comment alexhayton/svelte#${CIRCLE_PR_NUMBER} "🚀 Deployed a preview app to: ${DEPLOY_URL}"
fi
