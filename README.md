# gnoTodoApp

The Todo Application is a simple command-line application written in gno. It allows you to create, read, update, and delete todo items.

How to Run
To run the Todo Application, follow these steps:

Clone this repository to your local machine.

Install the gno tool from (https://github.com/gnolang/gno) and follow the setup guide for gno

You will then need to deploy the 3 contracts here using these commands (also found in the files themselves)

```
./build/gnokey maketx addpkg --pkgpath "gno.land/p/demo/markdown" -pkgdir "./p/markdown/" -gas-fee 50000000ugnot --gas-wanted 10000000 --broadcast --chainid dev --remote localhost:26657 g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5

./build/gnokey maketx addpkg -pkgpath "gno.land/p/demo/todo" -pkgdir "p/todoApp" -gas-fee 50000000ugnot --gas-wanted 10000000 --broadcast --chainid dev --remote localhost:26657 g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5   

./build/gnokey maketx addpkg -pkgpath "gno.land/r/gnoland/todo" -pkgdir "r/todoApp" -gas-fee 50000000ugnot --gas-wanted 10000000 --broadcast --chainid dev --remote localhost:26657 g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5   
```
Note that you will probably need to change the paths to match your gnokey binary's build location and where you store the contracts in this repo. 


Credits
The Todo Application was written by [Peyton Thibodeaux](https://github.com/Peyton232). Special thanks to [Florent Biville](https://github.com/fbiville) for their pmarkdown table library](https://github.com/fbiville/markdown-table-formatter) I used in the project.

Screenshots
<insert screenshots here>
