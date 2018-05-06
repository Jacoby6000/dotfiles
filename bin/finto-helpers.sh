#!/usr/local/bin/zsh
FHOST=169.254.169.254
#FPORT=16925
FPORT=80

function finto-ls() {
  curl -s ${FHOST}:${FPORT}/roles | python -m json.tool
}

function finto-get() {
  local alias=$1
  if [ -z "${alias}" ]; then echo "Error: requires alias"; return; fi
  curl -s ${FHOST}:${FPORT}/roles/${alias} | python -m json.tool
}

function finto-set() {
  local alias=$1
  if [ -z "${alias}" ]; then echo "Error: requires alias"; return; fi
  curl -s -XPUT -d "{\"alias\": \"${alias}\"}" ${FHOST}:${FPORT}/roles | python -m json.tool
}

function finto-active() {
  curl -s ${FHOST}:${FPORT}/roles\?status=active | python -m json.tool
}

