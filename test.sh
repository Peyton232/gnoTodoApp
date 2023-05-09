#!/bin/bash

## add a todo list named chores
./build/gnokey maketx call -pkgpath "gno.land/r/gnoland/todo" -func "AddBucket" -gas-fee 1000000ugnot -gas-wanted 2000000 -send "" -broadcast -chainid "dev" -args "chores" -remote "127.0.0.1:26657" g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5

## add 3 items to buck
./build/gnokey maketx call -pkgpath "gno.land/r/gnoland/todo" -func "AddTask" -gas-fee 1000000ugnot -gas-wanted 2000000 -send "" -broadcast -chainid "dev" -args "chores" -args "dishes" -args "description 1" -remote "127.0.0.1:26657" g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5
./build/gnokey maketx call -pkgpath "gno.land/r/gnoland/todo" -func "AddTask" -gas-fee 1000000ugnot -gas-wanted 2000000 -send "" -broadcast -chainid "dev" -args "chores" -args "laundry" -args "desc 2" -remote "127.0.0.1:26657" g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5
./build/gnokey maketx call -pkgpath "gno.land/r/gnoland/todo" -func "AddTask" -gas-fee 1000000ugnot -gas-wanted 2000000 -send "" -broadcast -chainid "dev" -args "chores" -args "wash the car" -args "a longer description" -remote "127.0.0.1:26657" g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5

## delete an item from buck
./build/gnokey maketx call -pkgpath "gno.land/r/gnoland/todo" -func "DeleteTask" -gas-fee 1000000ugnot -gas-wanted 2000000 -send "" -broadcast -chainid "dev" -args "chores" -args "laundry" -remote "127.0.0.1:26657" g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5

## mark items as complete
./build/gnokey maketx call -pkgpath "gno.land/r/gnoland/todo" -func "CompleteTask" -gas-fee 1000000ugnot -gas-wanted 2000000 -send "" -broadcast -chainid "dev" -args "chores" -args "dishes" -remote "127.0.0.1:26657" g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5
./build/gnokey maketx call -pkgpath "gno.land/r/gnoland/todo" -func "CompleteTask" -gas-fee 1000000ugnot -gas-wanted 2000000 -send "" -broadcast -chainid "dev" -args "chores" -args "wash the car" -remote "127.0.0.1:26657" g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5

## mark an item as uncomplete
./build/gnokey maketx call -pkgpath "gno.land/r/gnoland/todo" -func "UncompleteTask" -gas-fee 1000000ugnot -gas-wanted 2000000 -send "" -broadcast -chainid "dev" -args "chores" -args "wash the car" -remote "127.0.0.1:26657" g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5

## add a second todo list called work 
./build/gnokey maketx call -pkgpath "gno.land/r/gnoland/todo" -func "AddBucket" -gas-fee 1000000ugnot -gas-wanted 2000000 -send "" -broadcast -chainid "dev" -args "work" -remote "127.0.0.1:26657" g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5
