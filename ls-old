#!/bin/bash

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 DEPOT_SERVER [TARGET]"
    echo "  ls on the DEPOT_SERVER in the corresponding directory"
    exit
fi

DEPOT_SERVER=$1

TARGET=$(realpath ".")
if [[ $# -eq 2 ]]; then
    TARGET=$(realpath $2)
fi

ssh -t $DEPOT_SERVER ls -lG $TARGET
