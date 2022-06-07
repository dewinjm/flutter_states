#! /usr/bin/env bash

./scripts/flutter_test.sh

lcov --remove coverage/lcov.info -o coverage/lcov.info

genhtml coverage/lcov.info -o coverage/html    

echo "opening browser: ${PWD}/coverage/html/index.html"
open "${PWD}/coverage/html/index.html"
