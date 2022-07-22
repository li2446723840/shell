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
    # if [[ $(git diff --quiet) ]]; then  # 这个一点都不好使
    echo [[ $(git diff --check) ]]
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
mergeBranch
echo "git checkout $exploit_branch"
git checkout $exploit_branch

#
#
#
#
#
#
#
#
#
#
#
#
#
# 获取当前分支 两种方法
# 1、$(git rev-parse --abbrev-ref HEAD)
# 2、$(git symbolic-ref --short -q HEAD)
# exploit_branch=$(git rev-parse --abbrev-ref HEAD)
# isConflict=$(git diff --check) # 是否有冲突
# echo $isConflict
# ls # 列出当前文件夹下的文件
# git add .
# git commit -m
# currentBranch=develop
# 判断是否有develop分支
# if git rev-parse --verify dev; then
#   currentBranch=dev
# fi

# echo "####### 进入自己的项目 #######"

# ls

# echo "开始执行命令"

# git add .

# git status

# echo "####### 添加文件 #######"

# git commit -m "$2"

# echo "####### commit #######"

# echo "####### 开始推送 #######"

# if [ ! $3 ]
# then
#   echo "####### 请输入自己提交代码的分支 #######"
#   exit;
# fi

# git push origin "$3"

# echo "####### 推送成功 #######"
