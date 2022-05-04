#!/usr/bin/env bash
# Based on https://github.com/ejuarezg/containers/blob/master/iosevka_font/run.sh

set -e

# Create temporary build directory
mkdir /tmp/build
cd /tmp/build

BUILD_FILE="private-build-plans.toml"
BUILD_PARAM="contents::iosevka"

CUSTOM_BUILD_FILE=false

# Check the input
if [[ -f "/build/$BUILD_FILE" ]]; then
    echo "Found custom build-plans file: $BUILD_FILE"
    CUSTOM_BUILD_FILE=true
    if [[ -z $1 ]]; then
        # Get the name of the first build plan when the user does not provide
        # custom build arguments (automatic mode)
        PLAN_NAME=$(grep -Po -m 1 '(?<=buildPlans.)[^\]]*' /build/$BUILD_FILE)
        BUILD_PARAM="contents::$PLAN_NAME"
    else
        # User knows what they are doing and provided custom build arguments
        # (manual mode)
        BUILD_PARAM="$1"
    fi
else
    echo "Custom build-plans file not found, using the default one"
    if [[ -n $1 ]]; then
        echo -e "\nError: Custom build plan '$1' requested, but custom '$BUILD_FILE' file not found"
        exit 1
    fi
fi

echo "Using build plan: $BUILD_PARAM"

# Find the latest font version if the font version environment variable is not
# set. The `-n` operator checks if the length of the string is nonzero.
if [[ -z "$FONT_VERSION" ]]; then
    FONT_VERSION=$(curl -s -L https://github.com/be5invis/Iosevka/releases/latest \
        | grep -Po -m 1 '(?<=tag/v)[0-9.]*')
fi

echo "Using font version: ${FONT_VERSION}"

echo "Downloading and checking the validity of the source code..."

# Download source code
if [ "$FONT_VERSION" == "dev" ]; then
    curl -sSLo vdev.tar.gz --proto '=https' --tlsv1.2 https://github.com/be5invis/Iosevka/tarball/dev
else
    curl -sSLO --proto '=https' --tlsv1.2 https://github.com/be5invis/Iosevka/archive/v${FONT_VERSION}.tar.gz
fi

#  Check for valid downloaded file (build can fail here with exit code 1)
file "v${FONT_VERSION}.tar.gz" | grep 'gzip compressed data' > /dev/null

# Extract downloaded source code
tar -xf "v${FONT_VERSION}.tar.gz"
cd ./*Iosevka-*

if [ "$CUSTOM_BUILD_FILE" = true ]; then
    cp "/build/$BUILD_FILE" .
fi

echo "Building version ${FONT_VERSION}"
npm install
npm run build -- "$BUILD_PARAM"

# Copy the dist folder back to the mounted volume
cp -r dist /build/
