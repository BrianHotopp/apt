#!/bin/sh
set -e

eval $(apt-config shell APT_CONF_D Dir::Etc::parts/d)
test -n "${APT_CONF_D}" || APT_CONF_D="/etc/apt/apt.conf.d"
config_file="${APT_CONF_D}/01autoremove-kernels"

generateconfig() {
	cat <<EOF
// DO NOT EDIT! File autogenerated by $0
APT::LastInstalledKernel "$1";
EOF
}
generateconfig "$@" > "${config_file}.dpkg-new"
mv -f "${config_file}.dpkg-new" "$config_file"
chmod 444 "$config_file"
