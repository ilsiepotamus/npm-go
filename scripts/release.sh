#!/bin/bash

printf "\n\n******** NPM GO ********\n"
printf "You are about to create an OFFICIAL release of npm-go.\n"
printf "\nAre you ready to make this commitment? [y/n] "
read goforit
if [ $goforit != 'y' ];
then
	printf "\nCome back when you are ready to COMMIT. (har har)\n"
	printf "Ok. I'll show myself out.  Tip your waiter.\n\n"
	exit 1
fi

printf "\nSwitching to master branch and updating..."
git checkout master
git pull

printf "Here is a list of current releases:\n"
git for-each-ref --format '%(tag)' refs/tags

printf "\nWhat is your new version number?  Remember:\n"
printf "X: Major release or breaking change\n"
printf "Y: Features\n"
printf "Z: Patch\n"
printf "\nNew version number [X.Y.Z]: "
read new

for existing in $(git for-each-ref --format '%(tag)' refs/tags); do
	if [ $new = $existing ];
	then
		printf "Sorry, this version number is already taken.\n\n"
		exit 1
	fi
done

printf "\nUpdating package.json with version number $new...\n"
node node/update.js $new

printf "\nCommitting new version number and CHANGELOG.md...\n"
git commit -am"Changing version number for release"

printf "\nAdding version tag $new...\n"
git tag $new

printf "\nPushing everything to github...\n"
git push --tags origin master

printf "\nPublishing to NPM...\n"
npm login
npm publish --access=public
npm logout

printf "\nDone! Bye.\n\n"
