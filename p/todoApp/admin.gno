package todo

import (
	"std"
	"gno.land/p/demo/avl"
)

var (
	adminAddr     std.Address
	moderatorList avl.Tree
)

func init() {
	adminAddr = "g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5"
}

func AdminSetAdminAddr(addr std.Address) {
	assertIsAdmin()
	adminAddr = addr
}

func AdminAddModerator(addr std.Address) {
	assertIsAdmin()
	moderatorList.Set(addr.String(), true)
}

func AdminRemoveModerator(addr std.Address) {
	assertIsAdmin()
	moderatorList.Set(addr.String(), false)
}

func isAdmin(addr std.Address) bool {
	return addr == adminAddr
}

func assertIsAdmin() {
	caller := std.GetOrigCaller()
	if !isAdmin(caller) {
		panic("access restricted.")
	}
}