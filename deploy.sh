#!/bin/bash
# Use github worktree to generate a HUGO site directly into another branch:
# http://sangsoonam.github.io/2019/02/08/using-git-worktree-to-deploy-github-pages.html
# https://github.com/mapstruct/mapstruct.org/blob/master/scripts/publish.sh

directory=public
branch=gh-pages
build_command() {
  hugo
}

echo -e "\033[0;32mDeleting old content from $directory/ ...\033[0m"
rm -rf $directory

echo -e "\033[0;32mChecking out $branch....\033[0m"
git worktree add $directory $branch

echo -e "\033[0;32mGenerating site...\033[0m"
build_command

echo -e "\033[0;32mDeploying $branch branch...\033[0m"
cd $directory &&
  git add --all &&
  git commit -m "Deploy updates" &&
  git push -f origin $branch

echo -e "\033[0;32mCleaning up...\033[0m"
git worktree remove $directory