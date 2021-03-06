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
git clone "$gitRepo" "$gitrepos/$name"
if [ "$?" -ne "0" ]; then
  echo "repository $name doesn't exist"
  exit 1
fi
newProjectLocation="$gitrepos/$name"
echo "Cloned repo in $newProjectLocation"
templateDir="$gitrepos/template"
cp "$templateDir/cmake" "$templateDir/compile_commands.json" "$templateDir/src" "$templateDir/.gitignore" "$newProjectLocation" -r
mkdir "$newProjectLocation/build"
while true; do
	read -p "Do you wish to create a resources directory? (y/n) " yn
    case $yn in
        [Yy]* ) mkdir "$newProjectLocation/resources"; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
sed "s/template/$name/g" "$templateDir/CMakeLists.txt" > "$newProjectLocation/CMakeLists.txt"
echo "Done copying the template in the project directory"
cd "$newProjectLocation"
git add *
git commit -am "created project from template"
git pull
git push
