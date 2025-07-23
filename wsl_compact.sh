#!/bin/bash

main() {
  set -o errexit traceerr
  trap clean ERR

  vhdx='c:/Users/Evgen/AppData/Local/Packages/CanonicalGroupLimited.Ubuntu24.04LTS_79rhkp1fndgsc/LocalState/ext4.vhdx'
  wsl --shutdown
  wsl --list -v
  echo

script=$(cat <<-END
select vdisk file=$(cygpath -w $vhdx)
attach vdisk readonly
compact vdisk
detach vdisk
END
)
echo "$script" > $$_diskpart_script
  cat $$_diskpart_script
  echo
  stat $vhdx
  echo
  sudo diskpart /s '"'$(cygpath -w "$PWD/$$_diskpart_script")'"'
}

clean() {
  trap '' ERR
#   while ! rm -f $$_diskpart_script 2> /dev/null; do
#     sleep 1
#   done
#   stat $vhdx
}

main $*
clean
