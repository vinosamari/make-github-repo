#!/bin/bash

echo "╔╦╗┌─┐┬┌─┌─┐  ╔═╗┬┌┬┐┬ ┬┬ ┬┌┐    ╦═╗┌─┐┌─┐┌─┐
║║║├─┤├┴┐├┤───║ ╦│ │ ├─┤│ │├┴┐───╠╦╝├┤ ├─┘│ │
╩ ╩┴ ┴┴ ┴└─┘  ╚═╝┴ ┴ ┴ ┴└─┘└─┘   ╩╚═└─┘┴  └─┘"

#Check for jq
if command -v jq &> /dev/null; then
    echo ''
else
    echo "jq is not installed. Installing now..."
    if [ "$(uname)" == "Darwin" ]; then
        # Mac OS X
        if ! brew list jq &> /dev/null; then
            echo "Installing jq using Homebrew..."
            brew install jq
        fi
        elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        # Linux
        if ! apt-cache show jq &> /dev/null; then
            echo "Installing jq using apt-get..."
            sudo apt-get update
            sudo apt-get install jq
        fi
        elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
        # Windows NT
        echo "jq is not installed on Windows. Please install manually from https://stedolan.github.io/jq/"
        exit 1
    fi
fi
#Check for curl
if command -v curl &> /dev/null; then
    echo ''
else
    echo "curl is not installed. Installing now..."
    if [ "$(uname)" == "Darwin" ]; then
        # Mac OS X
        if ! brew list curl &> /dev/null; then
            echo "Installing curl using Homebrew..."
            brew install curl
        fi
        elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        # Linux
        if ! apt-cache show curl &> /dev/null; then
            echo "Installing curl using apt-get..."
            sudo apt-get update
            sudo apt-get install curl
        fi
        elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
        # Windows NT
        echo "curl is not installed on Windows. Please install manually from https://curl.haxx.se/windows/"
        exit 1
    fi
fi

#Input sanity check
if [ "$#" -lt 2 ]; then
    echo ""
    echo "❌ Error: At least 2 arguments are required (REPO_NAME, GITHUB_USERNAME, [github_personal_access_token])"
    echo ""
    echo "📖 Read the documentation at https://github.com/vinosamari/make-github-repo"
    exit 1
fi

#Set variables
repo_name=$1
github_username=$2
github_pat=${3:-$GITHUB_PAT}

# Check if the PAT is provided or set as an environment variable
if [ -z "$github_pat" ]; then
    echo ""
    echo "❌ Error: Github PAT not found. Please provide as the third argument or set as the GITHUB_PAT environment variable."
    echo ""
    echo "📖 Read the documentation at https://github.com/vinosamari/make-github-repo"
    exit 1
fi

# Create a repository for the authenticated user
curl -u "$github_username:$github_pat" https://api.github.com/user/repos -d "{\"name\":\"$repo_name\"" | jq '{name: .name, private: .private, html_url: .html_url, description: .description}'
echo "✅ Created Github Repo Successfully"
echo "╔╦╗┬ ┬┌─┐┌┐┌┬┌─  ┬ ┬┌─┐┬ ┬
 ║ ├─┤├─┤│││├┴┐  └┬┘│ ││ │
╩ ┴ ┴┴ ┴┘└┘┴ ┴   ┴ └─┘└─┘"
