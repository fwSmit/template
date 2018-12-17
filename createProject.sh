#!/bin/sh

if [ "$#" -ne 1 ] ; then
  echo "Usage: $0 repository name" >&2
  exit 1
fi

name=$1
# echo "creating project with the name $name"
# echo "this script assumes you have set up a github repo"
gitRepo="https://github.com/fwSmit/$name"
# echo "The github repo location is $gitRepo.git"
git clone $gitRepo ~/git_repos/$name
newProjectLocation="$HOME/git_repos/$name"
echo "Cloned repo in $newProjectLocation"
templateDir="$HOME/git_repos/template"
cp $templateDir/cmake $templateDir/compile_commands.json $templateDir/resources $templateDir/src $templateDir/.gitignore $newProjectLocation -r
mkdir $newProjectLocation/build
echo "Copied template project into the new repository"
sed "s/template/$name/g" $templateDir/CMakeLists.txt > $newProjectLocation/CMakeLists.txt
