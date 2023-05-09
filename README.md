# gnoTodoApp

The Todo Application is a simple command-line application written in gno. It allows you to create, read, update, and delete todo items.

## How to Run
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


## Credits
The Todo Application was written by [Peyton Thibodeaux](https://github.com/Peyton232). Special thanks to [Florent Biville](https://github.com/fbiville) for their pmarkdown table library](https://github.com/fbiville/markdown-table-formatter) I used in the project.

## Screenshots

### Initial View

<img width="1510" alt="Screenshot 2023-05-09 at 2 43 47 PM" src="https://github.com/Peyton232/gnoTodoApp/assets/42720832/0b847273-d69d-42a4-9a1a-87de26768f43">

### Added a todo list called chores

<img width="1510" alt="Screenshot 2023-05-09 at 2 44 00 PM" src="https://github.com/Peyton232/gnoTodoApp/assets/42720832/215b3ebe-42d3-4c06-abeb-357606876230">
<img width="1510" alt="Screenshot 2023-05-09 at 2 45 12 PM" src="https://github.com/Peyton232/gnoTodoApp/assets/42720832/5b4a9391-2893-440e-9a9e-5b0034d2ea3b">

### Added 3 new tasks to the todo list chores
<img width="1510" alt="Screenshot 2023-05-09 at 2 45 44 PM" src="https://github.com/Peyton232/gnoTodoApp/assets/42720832/3db7a178-aff7-451d-94ea-653dc5153fd1">

### Marking items as complete
<img width="1510" alt="Screenshot 2023-05-09 at 2 46 23 PM" src="https://github.com/Peyton232/gnoTodoApp/assets/42720832/43e0b3f7-d50a-4451-943b-d0db39e3c551">

###Supports multiple todo lists
<img width="1510" alt="Screenshot 2023-05-09 at 2 46 53 PM" src="https://github.com/Peyton232/gnoTodoApp/assets/42720832/de224d41-23e7-4875-84b4-4ea83a745774">
