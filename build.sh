#!/bin/bash
# if [ ! $1 ]; then
#   echo "####### 请输入自己的项目 #######"
#   read projectPath
# else
#   projectPath=$1
# fi
# echo "####### 当前项目名：$projectPath #######"

if [ ! $1 ]; then
  echo "####### 请输入commit值 #######"
  read commitText
else
  commitText=$1
fi
echo "####### 当前commit值：$commitText #######"

#给出一个默认的项目路径
# path="D://works/$projectPath"
# echo "当前路径：$path"

# cd $path
# 判断工作树是否干净
judgeWorkTreeIsClear() {
  judgeIsHasConflict
  if [[ $(git status -s) ]]; then
    echo "git add ."
    git add .
    echo "git commit -m $commitText"
    git commit -m "$commitText"
  else
    echo "working tree clean(干净的工作树)"
  fi
}
# 判断是否有冲突
judgeIsHasConflict() {
  if [[ $(git diff --check) ]]; then
    echo ">>>>请先解决冲突<<<<"
    exit
  else
    echo "没有冲突"
  fi
}
# 合并分支
mergeBranch() {
  echo "目标分支：$targeBranch"
  echo "git checkout $targeBranch"
  git checkout $targeBranch
  echo "已切换到$targeBranch分支"
  echo "git pull"
  git pull
  echo "git merge $exploit_branch"
  git merge $exploit_branch
  echo "npm run build"
  npm run build
  judgeWorkTreeIsClear
  echo "git push"
  git push
}

# 当前开发分支
exploit_branch=$(git rev-parse --abbrev-ref HEAD)
echo "当前开发分支：$exploit_branch"
judgeWorkTreeIsClear
git pull
targeBranch=develop

if [[ $(git rev-parse --verify dev) ]]; then
  targeBranch=dev
  echo "切换到dev分支"
else
  echo "没有dev分支"
fi
mergeBranch
targeBranch=test
# buildPrefix=test
mergeBranch
echo "git checkout $exploit_branch"
git checkout $exploit_branch
