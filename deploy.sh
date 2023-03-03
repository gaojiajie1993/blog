#!/usr/bin/env sh

# ------------------------------------------------------------------------------
# gh-pages 部署脚本
# @author gaojiajie1993
# @since 2023/1/10
# ------------------------------------------------------------------------------

# 装载其它库
ROOT_DIR=$(
  cd $(dirname $0)
  pwd
)

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
npm install
npm run build

# 进入生成的文件夹
cd ${ROOT_DIR}/.temp

# 如果是发布到自定义域名
# echo 'www.example.com' > CNAME

if [[ ${GITHUB_TOKEN} ]]; then
  msg='自动部署'
  GITHUB_URL=https://gaojiajie1993:${GITHUB_TOKEN}@github.com/gaojiajie1993/blog.git
  git config --global user.name "gaojiajie1993"
  git config --global user.email "gaojiajie1993@163.com"
else
  msg='手动部署'
  GITHUB_URL=git@github.com:gaojiajie1993/blog.git
fi
git init
git add -A
git commit -m "${msg}"
# 推送到github gh-pages分支
git push -f "${GITHUB_URL}" master:gh-pages

rm -rf ${ROOT_DIR}/.temp
