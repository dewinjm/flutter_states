#! /usr/bin/env bash

flutter test --coverage

lcov --remove coverage/lcov.info -o coverage/lcov.info
genhtml coverage/lcov.info -o coverage/html    

open "${PWD}/coverage/html/index.html"
