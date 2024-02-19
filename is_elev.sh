#!/bin/bash


# 0 - success, 1 - fail
id | grep 114 > /dev/null && exit 0 || exit 1
