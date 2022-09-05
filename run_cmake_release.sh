#!/usr/bin/env bash

. $PWD/../set_cmake_variables.sh

CMAKE_ARGS="-Wno-dev -DCMAKE_BUILD_TYPE=Release"
CMAKE_ARGS="$CMAKE_ARGS -DHUNTER_STATUS_DEBUG=ON -DCABLE_DEBUG=ON -DCMAKE_VERBOSE_MAKEFILE=ON"
CMAKE_ARGS="$CMAKE_ARGS -DBUILD_SHARED_LIBS=OFF -DOPENSSL_USE_STATIC_LIBS=ON"
CMAKE_ARGS="$CMAKE_ARGS -DBoost_USE_STATIC_LIBS=ON -DBoost_USE_STATIC_RUNTIME=ON"

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
