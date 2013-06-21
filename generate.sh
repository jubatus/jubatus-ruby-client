#!/bin/bash -ue

JUBATUS_DIR="jubatus-generate"
JUBATUS_BRANCH="master"
CLIENT_DIR="$(cd $(dirname ${0}) && echo ${PWD})"

[ $# -eq 0 ] || JUBATUS_BRANCH="${1}"

rm -rf "${JUBATUS_DIR}"
git clone https://github.com/jubatus/jubatus.git "${JUBATUS_DIR}"
pushd "${JUBATUS_DIR}"
git checkout "${JUBATUS_BRANCH}"
popd

# Ruby

capitalize() {
  echo "$(echo ${1:0:1} | tr 'a-z' 'A-Z')${1:1}"
}

rm -rf "${CLIENT_DIR}/lib"
pushd "${JUBATUS_DIR}/jubatus/server/server"
for IDL in *.idl; do
  NAMESPACE="$(capitalize $(basename "${IDL}" ".idl"))"
  jenerator -l ruby "${IDL}" -n "Jubatus::${NAMESPACE}" -o "${CLIENT_DIR}/lib/jubatus"
done
popd

rm -rf "${JUBATUS_DIR}"
