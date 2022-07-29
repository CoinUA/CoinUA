#!/usr/bin/env bash
set -x
set -e

export LC_ALL=C

cd "${DATA_DIR}"

if [ ! -d src ]; then
  git clone https://github.com/CoinUA/CoinUA.git src
fi

mkdir -p build

cd src
#git switch "${GIT_BRANCH}"
git fetch --all
#git fetch
git checkout "${GIT_BRANCH}"
git pull -X theirs

if [ -z "${UPDATE_BUILD}" ]; then

  rm -rf "${BUILD_HOST}"
  mkdir -p "${BUILD_HOST}"

  cd depends
  make -j"${BUILD_WORKERS}" HOST="${BUILD_HOST}"
  CONFIGURE="--disable-tests --disable-bench --enable-cxx --disable-shared --with-pic --prefix=$(pwd)/${BUILD_HOST}"

  cd ../"${BUILD_HOST}"
  ../autogen.sh

  if [ -z "${DEBUG_FLAGS}" ]; then
    ../configure --host="${BUILD_HOST}" ${CONFIGURE}
  else
    export CFLAGS='-g3 -Og'
    export CXXFLAGS='-g3 -Og'
    ../configure --host="${BUILD_HOST}" ${CONFIGURE} --enable-debug
  fi

else
  cd "${BUILD_HOST}"
fi

make -j"${BUILD_WORKERS}"
make install DESTDIR=/tmp
rm -rf "${DATA_DIR}"/build/"${BUILD_HOST}"
mv /tmp"${DATA_DIR}"/src/depends/"${BUILD_HOST}" "${DATA_DIR}"/build/
