package gnotasks 

import (
	"std"

	"gno.land/p/demo/blog"
	logic "gno.land/p/demo/todo"
)

// ./build/gnokey maketx addpkg -pkgpath "gno.land/r/gnoland/todo" -pkgdir "r/todoApp" -gas-fee 50000000ugnot --gas-wanted 10000000 --broadcast --chainid dev --remote localhost:26657 g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5   

var m = &logic.TodosManager{
	Title:  "Gnoland's Todo App",
	Prefix: "/r/gnoland/todo:",
}

func Render(path string) string {
	return m.Render(path)
}