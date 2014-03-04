#!/bin/bash
baseDir=$PWD
installationDir=${baseDir}/installations
targetForPkgs=${baseDir}/requiredPkgs
## install xz
cd $installationDir
xzSrc="http://tukaani.org/xz/xz-5.0.5.tar.gz"
wget $xzSrc
xzTgz=`echo $xzSrc | sed 's/^.*\/\(xz-[0-9\.]\.[^\/]*\)$/\1/'`
xzDirname=`echo $xzTgz | sed 's/^\(xz-[0-9\.]\)\.[^\/]*$/\1/'`
xzDir=${targetForPkgs}/$xzDirname
cd $installationDir
tar -xzf $xzTgz
cd $xzDirname
./configure --prefix=$xzDir
make;
make install
## install libarchive
cd $installationDir
libArchivSrc="https://github.com/downloads/libarchive/libarchive/libarchive-2.8.5.tar.gz"
wget $libArchivSrc 
libArTgz=`echo $libArchivSrc | sed 's/^.*\/\(libarchive-[0-9\.]\.[^\/]*\)$/\1/'`
libArDirname=`echo $libArTgz | sed 's/^\(libarchive-[0-9\.]\)\.[^\/]*$/\1/'`
libArDir=${targetForPkgs}/$libArDirname
tar -xzf $libArTgz
cd $libArDirname
./configure --prefix=$libArDir
export CFLAGS="-I${xzDir}/include"
export LDFLAGS="-I${xzDir}/lib"
make;
make install

