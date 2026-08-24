#! /bin/bash

mkdir -p src
git clone git@github.com:ORTHOPUS-EXPLORER/explorer_docs.git
cd src
git clone --recursive -b prod/poc2 git@github.com:ORTHOPUS-EXPLORER/explorer_ws.git

