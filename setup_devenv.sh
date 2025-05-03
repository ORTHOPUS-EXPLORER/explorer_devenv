#! /bin/bash

mkdir -p src

git clone git@bitbucket.org:orthopusactuators/explorer_docs.git
mkdir src
cd src
git clone --recursive git@bitbucket.org:orthopusactuators/explorer_ws.git

