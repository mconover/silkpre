#!/usr/bin/env bash

CMAKE_ARGS="-Wno-dev -DCMAKE_BUILD_TYPE=Debug"
CMAKE_ARGS="$CMAKE_ARGS -DHUNTER_STATUS_DEBUG=ON -DCABLE_DEBUG=ON -DCMAKE_VERBOSE_MAKEFILE=ON"
CMAKE_ARGS="$CMAKE_ARGS -DBUILD_SHARED_LIBS=OFF -DOPENSSL_USE_STATIC_LIBS=ON"

export GMP_LIBRARY=/usr/lib/x86_64-linux-gnu
export GMP_INCLUDE_DIR=/usr/include/x86_64-linux-gnu
INCLUDE=$GMP_INCLUDE_DIR:$INCLUDE
LIBRARY=$GMP_INCLUDE_DIR:$LIBRARY

export BOOST_INCLUDEDIR=/usr/include/boost
export BOOST_LIBRARYDIR=/usr/lib/x86_64-linux-gnu
export BOOST_ROOT=/usr/lib/x86_64-linux-gnu/cmake/Boost-1.71.0
INCLUDE=$GMP_INCLUDE_DIR:$INCLUDE
LIBRARY=$BOOST_LIBRARYDIR:$LIBRARY
CMAKE_ARGS="$CMAKE_ARGS -DBOOST_ROOT=$BOOST_ROOT -DBoost_USE_STATIC_LIBS=ON -DBoost_USE_STATIC_RUNTIME=ON"

if [ "$1" == "build" ]
then
	CMAKE_ARGS="--build . --verbose"
else
	CMAKE_ARGS="$CMAKE_ARGS .."
fi

echo "*** Running: cmake $CMAKE_ARGS"
cmake $CMAKE_ARGS
error=$?
echo "cmake returned $error"
exit $?
