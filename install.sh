#!/bin/bash
baseDir=$PWD
installationDir=${baseDir}/installations
targetForPkgs=${baseDir}/requiredPkgs
## install xz
cd $installationDir
xzSrc="http://tukaani.org/xz/xz-5.0.5.tar.gz"
wget $xzSrc
xzDir=${targetForPkgs}/`echo $xzSrc | sed 's/^.*\/\(xz-[0-9\.]*\)\.[^\/]*$/\1/'`
echo $xzDir
#cd $installationDir
#tar -xzf xz-5.0.5.tar.gz
#cd xz-5.0.5
#./configure --prefix=$xzDir
#make, make install
### install libarchive
#cd $installationDir
#wget https://github.com/downloads/libarchive/libarchive/libarchive-2.8.5.tar.gz
