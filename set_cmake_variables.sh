#!/usr/bin/env bash


export HUNTER_PROJECTS=$HOME/.hunter/_Base/Download/Hunter/0.24.3/10738b5/Unpacked/cmake/projects

export mimalloc_DIR=/usr/local/lib/cmake/mimalloc-2.0
INCLUDE=/usr/local/include:$INCLUDE
LIBRARY=/usr/local/lib:$LIBRARY

export GMP_LIBRARY=/usr/lib/x86_64-linux-gnu
export GMP_INCLUDE_DIR=/usr/include/x86_64-linux-gnu
INCLUDE=$GMP_INCLUDE_DIR:$INCLUDE
LIBRARY=$GMP_INCLUDE_DIR:$LIBRARY

export BOOST_INCLUDEDIR=/usr/include/boost
export BOOST_LIBRARYDIR=/usr/lib/x86_64-linux-gnu
export BOOST_ROOT=/usr/lib/x86_64-linux-gnu/cmake/Boost-1.71.0
export INCLUDE=$GMP_INCLUDE_DIR:$INCLUDE
export LIBRARY=$BOOST_LIBRARYDIR:$LIBRARY
