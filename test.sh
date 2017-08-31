#!/bin/bash

set -e

fetch() {
	local svn_path

	if [[ "$svn_branch" = "trunk" ]]; then
		svn_path="/trunk"
	else if [[ "$svn_branch" != "" ]]; then
		svn_path="/branches/$svn_branch"
	else if [[ "$svn_tag" != "" ]]; then
		svn_path="/tags/$svn_tag"
	else
		svn_path="/trunk"
	fi

	svn checkout --quiet $repo/$svn_path /ruby/build_source
}

ruby_install() {
	cd /ruby/build_source
	autoconf

	cd /ruby/build
	../source/configure \
		--prefix=/ruby/install \
		--enable-shared

	make -j
	make install-nodoc
}

install_gem() {
	local gem=$1
	local version=$2

	if [[ "$version" = "" ]]; then
		gem install $gem
	else
		gem install $gem -v $version
	fi
}

detect_test_command() {
	local gem=$1
	local version=$2

	cd /ruby/
}

gem=$1
version=$2

export PATH="/ruby/install/bin:$PATH"

cd /ruby

if [[ -f /ruby/source/vm.c ]]; then
	cp -r /ruby/source/* /ruby/build_source/
else
	fetch_source
fi

ruby_install
install_gem $1 $2

