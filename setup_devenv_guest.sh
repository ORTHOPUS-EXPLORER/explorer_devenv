#! /bin/bash

mkdir -p src

git clone https://github.com/ORTHOPUS-EXPLORER/explorer_docs.git
mkdir src
cd src
git clone --recursive -b prod/poc2 https://github.com/ORTHOPUS-EXPLORER/explorer_ws.git

