#!/usr/bin/env bash

(cd img && rm -f big_* && for file in *.png; do convert $file -scale 2048x2048 big_$file; done)