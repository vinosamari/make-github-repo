# MAKE-GITHUB-REPO

## INTRODUCTION

This script is designed to automate the creation of a Github repository for the authenticated user. The repository will be created with the provided name, and the authentication is done using a [Github personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)

### Prerequisites

- `jq` and `curl` must be installed on your machine. If they are not installed, the script will attempt to install them automatically.
- A Github personal access token (PAT) must be obtained and passed to the script as an argument or set as an environment variable GITHUB_PAT.

### Getting started

- In order to use the script, you will need to clone the repository to your local machine. You can do this by running the following command in your terminal or Git Bash:
```
git clone https://github.com/vinosamari/make-github-repo.git
```

- After cloning the repository, navigate to the script directory using the following command:
```
cd make-github-repo
```

- Now, you need to make the script executable. You can do this by running the following command:
```
chmod +x make-github-repo.sh
```


### Usage
To run the script, pass the repository name and Github username as arguments. A Github PAT can be passed as the third argument, or it can be set as the GITHUB_PAT environment variable.
```
./make-github-repo.sh REPO_NAME GITHUB_USERNAME [github_personal_access_token]
```

### Example
```
#If $GITHUB_PAT not set in environment variables

./make-github-repo.sh my-new-repo vinosamari abcdefghijklmnopqrstuvwxyz1234567890

```

#### Alternatively you can save the token as an environment variable;
```
export GITHUB_PAT=abcdefghijklmnopqrstuvwxyz1234567890

./make-github-repo.sh my-new-repo vinosamari

```

### Output
On successful execution, the script will return a JSON object containing the repository details, including the repository name, private/public status, HTML URL, and description.
```
{
  "name": "my-new-repo",
  "private": false,
  "html_url": "https://github.com/vinosamari/my-new-repo",
  "description": null
}
✅ Created Github Repo Successfully

```

## TODO

- Allow username to be optional by saving as an environment variable.
- Modularize it so that it can be plugged into other CLI commands on demand.
