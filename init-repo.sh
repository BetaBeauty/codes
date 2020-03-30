#!/bin/bash

source git-config.sh

print_help() {
  if [[ $# != 0 ]]; then
    echo "ERROR with: $@"
    echo
  fi

cat << END_OF_HELP
Usage -- initalize a subtree directory with predefined code
END_OF_HELP

}

CUR_DIR=`pwd`
REPO="${1//./\/}"
TEMPLATE=.template

if [[ "${REPO}" == "" ]]; then
  print_help "sub repo is not set"
  exit 0
fi

if [[ -e ${REPO} ]]; then
  echo "Sub directory:${REPO} has been created"
  exit
fi

mkdir -p ${REPO}

cd ${REPO}

cp -r ${CUR_DIR}/${TEMPLATE}/. .
git init
git add .
git commit -am "initalize"

REMOTE="git@${GIT_WEBSITE}:${GIT_USER}/${REPO}.git"
echo "Remote Git: ${REMOTE}"
git remote add origin ${REMOTE}
git push --set-upstream origin master

cd ${CUR_DIR}