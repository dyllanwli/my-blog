#!/bin/bash

# This scripts is used for clear the package and environment

CURRENT_DIR=${PWD}

trash -rf node_modules
trash package-lock.json
trash -rf /tmp/*

