function mr
    set -l PROJECT_PATH (git config --get remote.origin.url | sed 's/^ssh.*@[^/]*\(\/.*\).git/\1/g')

    set -l CURRENT_BRANCH_NAME (git branch --show-current)
    set -l GITLAB_MR_URL "$GITLAB_BASE_URL$PROJECT_PATH/-/merge_requests/new?merge_request%5Bsource_branch%5D=$CURRENT_BRANCH_NAME"
    open "$GITLAB_MR_URL"
end