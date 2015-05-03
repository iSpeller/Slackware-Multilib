#!/usr/bin/env bash

# ===================================================== #
# 如有BUG 请提交Issues                                  #
# https://github.com/iSpeller/Slackware-Multilib/issues #
#                                                       #
#             Copyright (C) 2014-2015 iSpeller          #
# ===================================================== #
source /usr/local/lib/check_environment.sh
source /usr/local/lib/main_window.sh
source /usr/local/lib/get_arch.sh
source /usr/local/lib/install_multilib.sh

version=''
target=''
arch=''
use_dialog=''
work_directory=''
cache_directory=''

# MAIN () {
  # 决定是否使用dialog
  if [[ -x /usr/bin/dialog ]]; then
    use_dialog=true
  else
    use_dialog=false
  fi

  # 设定工作目录
  work_directory=$HOME/.Slackware-Multilib
  if [[ ! -d $work_directory ]]; then
    mkdir -p "$work_directory"
  fi

  # 检查环境是否满足
  check_environment $use_dialog
  if [[ 0 == $? ]]; then
    exit 1
  fi

  # 得到Multilib 的版本号
  version_file=$work_directory/version
  main_window $use_dialog $work_directory
  version=$(cat "$version_file")

  # 得到架构
  arch_file=$work_directory/arch
  get_arch $use_dialog $work_directory
  arch=$(cat "$arch_file")

  # 构造缓存目录
  cache_directory=/tmp/Slackware-Multilib/$version
  if [[ ! -e $cache_directory ]]; then
    mkdir -p $cache_directory
  fi

  # 安装Multilib
  install_multilib $use_dialog $cache_directory $version

  # 结尾的清理工作
  rm -rf "$work_directory"

  exit 0
# }

