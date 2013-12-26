#!/bin/bash

# build-jquery.sh
# ---------------------
# Chris Zarate, 2013-10

# This script allows for lighter-weight jQuery using a custom build.
# https://github.com/jquery/jquery#how-to-build-your-own-jquery


# Build options.
tag=1.10.2
options=-deprecated,-dimensions,-effects,-event/alias,-offset,-wrap,-exports/amd,-core/ready

# Get current directory.
current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change working directory.
cd ${current_dir}/../app

# Destroy existing jQuery.
rm -rf bower_components/jquery

# Clone repository.
mkdir -p bower_components && cd bower_components
git clone git://github.com/jquery/jquery.git && cd jquery

# Checkout desired tag.
git checkout $tag

# Build.
npm install
grunt
grunt custom:${options}

# Copy to repository root to mirror Bower component location.
cp dist/jquery.min.js jquery.min.js
