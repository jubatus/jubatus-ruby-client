#!/bin/bash -ue

JUBATUS_DIR="jubatus-generate"
JUBATUS_BRANCH="master"
CLIENT_DIR="$(cd $(dirname ${0}) && echo ${PWD})"

[ $# -eq 0 ] || JUBATUS_BRANCH="${1}"

rm -rf "${JUBATUS_DIR}"
curl -L "https://github.com/jubatus/jubatus/archive/${JUBATUS_BRANCH}.tar.gz" | tar xz
mv "jubatus-${JUBATUS_BRANCH}" "${JUBATUS_DIR}"

# Ruby

for DIR in "${CLIENT_DIR}/lib/jubatus/"*; do
  if [ -d "${DIR}" ] && [ "$(basename "${DIR}")" != "common" ]; then
    rm -rf $DIR
  fi
done
pushd "${JUBATUS_DIR}/jubatus/server/server"
for IDL in *.idl; do
  IDL_HASH=`git log -1 --format=%H -- ${IDL}`
  IDL_VER=`git describe ${IDL_HASH}`
  NAMESPACE="$(basename "${IDL}" ".idl")"
  jenerator -l ruby "${IDL}" -n "Jubatus::${NAMESPACE}" -o "${CLIENT_DIR}/lib/jubatus" --idl-version $IDL_VER
done
popd

rm -rf "${JUBATUS_DIR}"
