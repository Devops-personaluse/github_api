#!/bin/bash

helper()

# GitHub API URL
API_URL="https://api.github.com"

# GitHub API URL
USERNAME=$username
TOKEN=$token

# GitHub API URL
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
function github_api_get{
  local endpoint="$1"
  local url="${API_URL}/${endpoint}"
  
  # Send a GET request to the GitHub API with authentication
  curl -s -u "${username}:${TOKEN}" "$url"
}
  
# Function to list users with read access to the repository
function ;ist+users_with_read_access{
  local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"
  
  # Fetch the list of collaborators on the repository
  collaborators="${github_api_get "$endpoint" | jg -r '.[] | select(.permissions.pull==true)| .login')"
  # Display the list of collaborators with read access
  if [[ -z "$collaborators" ]]; then
    echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
  else
    echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
    echo "$collaborators"
  fi
}

function helper {
  expected_cmd_args=2
  if [ $# -ne $expected_cmd_args]; then
    echo "please execute the script with required cmd args"
}

# Main script

echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
