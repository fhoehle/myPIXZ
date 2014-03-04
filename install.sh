#!/bin/bash
baseDir=$PWD
installationDir=${baseDir}/installations
mkdir -p $installationDir
targetForPkgs=${baseDir}/requiredPkgs
## install xz
cd $installationDir
xzSrc="http://tukaani.org/xz/xz-5.0.5.tar.gz"
wget $xzSrc
xzTgz=`echo $xzSrc | sed 's/^.*\/\(xz-[0-9\.]*\.[^\/]*\)$/\1/'`
xzDirname=`echo $xzTgz | sed 's/^\(xz-[0-9\.]*\)\.[^\/]*$/\1/'`
xzDir=${targetForPkgs}/$xzDirname
cd $installationDir
tar -xzf $xzTgz
cd $xzDirname
./configure --prefix=$xzDir
make -j 4;
make install
## install libarchive
cd $installationDir
libArchivSrc="https://github.com/downloads/libarchive/libarchive/libarchive-2.8.5.tar.gz"
wget --no-check-certificate $libArchivSrc 
libArTgz=`echo $libArchivSrc | sed 's/^.*\/\(libarchive-[0-9\.]*\.[^\/]*\)$/\1/'`
libArDirname=`echo $libArTgz | sed 's/^\(libarchive-[0-9\.]*\)\.[^\/]*$/\1/'`
libArDir=${targetForPkgs}/$libArDirname
tar -xzf $libArTgz
cd $libArDirname
./configure --prefix=$libArDir
export CFLAGS="-I${xzDir}/include"
export LDFLAGS="-L${xzDir}/lib"
make -j 4;
make install
## install pixz
cd $installationDir
pixzSrc="http://downloads.sourceforge.net/project/pixz/pixz-1.0.2.tgz"
wget $pixzSrc
pixzTgz=`echo $pixzSrc | sed 's/^.*\/\(pixz-[0-9\.]*\.[^\/]*\)$/\1/'`
pixzDirname=`echo $pixzTgz| sed 's/^\(pixz-[0-9\.]*\)\.[^\/]*$/\1/'`
pixzDir=$installationDir/$pixzDirname
tar -xzf $pixzTgz
mkdir -p $pixzDir
mv $pixzDirname/* $pixzDir/
cd $pixzDir/
export CFLAGS="-I${libArDir}/include "$CFLAGS
export LDFLAGS="-L${libArDir}/lib "$LDFLAGS
patch < $baseDir/pixzPatch.txt
make 
make install
