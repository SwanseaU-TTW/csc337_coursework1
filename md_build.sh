#!/usr/bin/env bash

pandoc -t latex -o renamewithstudentnumber.pdf -s submission.md \
  part1/design1.md part1/design2.md part1/design3.md part1/design4.md part1/design5.md \
  part2/treemap1.md part2/treemap2.md part3/p3.md
