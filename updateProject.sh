#!/bin/sh
# updates an old project
# this script does the following:
# - replace an old CMakeLists.txt file with a better one
# - move all source and header files to src/
if [ "$#" -ne 1 ] ; then
  echo "Usage: $0 repository name" >&2
  exit 1
fi

name=$1
newProjectLocation="$HOME/git_repos/$name"
templateDir="$HOME/git_repos/template"
cp $templateDir/cmake $templateDir/compile_commands.json $templateDir/.gitignore $newProjectLocation -r
mkdir $newProjectLocation/resources $newProjectLocation/src
mv $newProjectLocation/CMakeLists.txt $newProjectLocation/oldCMakeLists.txt
mv $newProjectLocation/*.{cpp,h} $newProjectLocation/src
mv $newProjectLocation/src/source.cpp $newProjectLocation/src/main.cpp
sed "s/template/$name/g" $templateDir/CMakeLists.txt > $newProjectLocation/CMakeLists.txt
