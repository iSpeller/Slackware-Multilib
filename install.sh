#!/usr/bin/env bash

cwd=$(dirname $(readlink -f $0))
exec_target='/usr/local/bin/multilib'
exec_file="$cwd/bin/Slackware-Multilib.sh"
lib_target='/usr/local/lib'
lib_dir="$cwd/lib"
lib_files=('check_environment.sh' 'get_arch.sh' 'install_multilib.sh' 'main_window.sh')
answer=''

if [[ 0 -ne $UID ]]; then
  echo "请使用root 权限运行$0。"
  exit 1
fi

if [[ -e $exec_target ]]; then
  read -p '发现系统内已经存在一份Slackware-Multilib，要覆盖它吗？(Y/n)' answer
  if [[ 'Y' != $answer ]]; then
    echo '确认询问未通过，Slackware-Multilib 未安装。'
    exit 1
  fi
fi

cp -f "$exec_file" "$exec_target"

i=0
while [[ $i < ${#lib_files[@]} ]]; do
  lib_files[$i]=$lib_dir/${lib_files[$i]}
  let ++i
done

# now answer is yes
for lib_file in ${lib_files[@]}; do
  cp -f "$lib_file" "$lib_target"
done

if [[ 0 -eq $? ]]; then
  echo "已经安装到$exec_target。"
else
  exit $?
fi

