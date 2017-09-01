#!/bin/bash

set -e

fetch() {
	local svn_path

	svn checkout --quiet $RUBY_REPO/$RUBY_BRANCH /ruby/build_source
}

ruby_install() {
	cd /ruby/build_source
	autoconf

	cd /ruby/build
	../build_source/configure \
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
