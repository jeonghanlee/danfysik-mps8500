#!/bin/bash
#
#  Copyright (c) 2016 Jeong Han Lee
#  Copyright (c) 2016 European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# Author  : Jeong Han Lee
# email   : han.lee@esss.se
# Date    : Monday, November 28 11:41:01 CET 2016
# version : 0.0.1



if [ -z "$1" ]; then
     printf "\n";
     printf "usage: %16s \"pv list file\"\n\n" "$0"

     exit 1;
fi

declare -a pvlist=();
declare cmd="caget"

substring=$1

for i in `seq 0 15`; do
    pvlist[i]="$1";
    pvlist[i]+=$(printf ".B%X" "$i" | tr [:lower:] [:upper:] );
done    

$cmd ${pvlist[@]}
