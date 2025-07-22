#!/bin/bash
# https://docs.easybuild.io/installation/#eb_as_module

set -e

# to fix error on Hawk:
# TypeError: expected str, bytes or os.PathLike object, not int
export PIP_NO_CACHE_DIR=off

# to workaround old module tool on Hawk
ModulesTool=EnvironmentModulesC
export EASYBUILD_MODULES_TOOL=$ModulesTool
export EASYBUILD_MODULE_SYNTAX=Tcl

#
# Step 1: Installing EasyBuild into a temporary location
#

# pick installation prefix, and install EasyBuild into it
export EB_TMPDIR=/tmp/$USER/eb_tmp
python3 -m pip install --ignore-installed --prefix $EB_TMPDIR easybuild

# update environment to use this temporary EasyBuild installation
export PATH=$EB_TMPDIR/bin:$PATH
export PYTHONPATH=$(/bin/ls -rtd -1 $EB_TMPDIR/lib*/python*/site-packages | tail -1):$PYTHONPATH
export EB_PYTHON=python3

#
# Step 2: Using EasyBuild to install EasyBuild
#

root=$HOME/easybuild
eb --install-latest-eb-release --prefix $root

#
# More steps, setup a file to hold a config file
#

mkdir -p $root/etc
eb --confighelp > $root/etc/config.cfg
sed -i "s,^#prefix=,prefix=$root," $root/etc/config.cfg
