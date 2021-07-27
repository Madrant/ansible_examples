#!/bin/bash

# Exit on error
set -e

# Parse commnaline parameters
url="${1}"

if [ -z "${url}" ]; then
    echo "Provide URL to connect to: user@host"
    exit 1
fi

key_path="~/.ssh"
key_type="rsa"
key_pass=""
overwrite="y"

keygen_cmd="ssh-keygen -t ${key_type} -q -N '${key_pass}' -f ${key_path}/${url}"

# Generate public key for a given server

echo "Generating local key-pair: ${keygen_cmd}"
eval "${keygen_cmd}"

# Copy generated public key to server

echo "Copying public keys to ${url}"
ssh-copy-id ${url}
