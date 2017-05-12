#!/bin/bash

pandoc -t beamer -H preamble.tex intro.md \
    --slide-level 2 \
    --latex-engine=pdflatex \
    --highlight-style zenburn \
    -o ./output/intro.pdf
