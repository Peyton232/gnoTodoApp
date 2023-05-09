package todo

import (
	"errors"
	"std"
	"strconv"
	"strings"
	"time"

	"gno.land/p/demo/avl"
	"gno.land/p/demo/ufmt"
)

// ./build/gnokey maketx addpkg -pkgpath "gno.land/p/todoapp" -pkgdir "p/todoApp" -gas-fee 50000000ugnot --gas-wanted 10000000 --broadcast --chainid dev --remote localhost:26657 g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5   

type TodosManager struct {
	Title  string
	Prefix string   // i.e. r/gnoland/blog:
	Lists  avl.Tree // gno address -> TodoBucket
}

func (m TodosManager) Render(path string) string {
	parts := strings.Split(path, "/")

	isHome := path == ""
	isViewList := len(parts) == 2 && parts[0] == "p" && len(parts[1]) > 0

	switch {
	case isHome:
		output := breadcrumb([]string{m.Title})

		if m.Lists.Size() == 0 {
			output += "No lists."
			return output
		}

		m.Lists.Iterate("", "", func(n *avl.Node) bool {
			bucket := n.Value().(*TodoBucket)
			output += bucket.RenderListItem()
			return false
		})
		return output
	case isViewList:
		name := parts[1]

		todoList, found := m.Lists.Get(name)
		if !found {
			return "404" 
		}
		t := todoList.(*TodoBucket)

		// task list title
		output := breadcrumb([]string{
			ufmt.Sprintf("[%s](%s)", m.Title, m.Prefix),
			"p",
			t.Name,
		})

		output += t.renderTaskList(m.Prefix)

		return output
	}
	return "404"
}

func (m *TodosManager) AddBucket(name string) error {
	name = strings.TrimSpace(name)
	_, found := m.Lists.Get(name)
	if found {
		return errors.New("bucket already exists.")
	}

	bucket := TodoBucket{
		Name:    name,
		Tasks: make([]Task, 0),
		Prefix: m.Prefix,
		Owner: std.GetOrigCaller(),
	}
	return m.prepareAndSetBucket(&bucket)
}

func (m *TodosManager) prepareAndSetBucket(bucket *TodoBucket) error {
	// there shouldn't be a scenario where this is needed, but better safe than sorry
	if bucket.Tasks == nil {
		bucket.Tasks = make([]Task, 0)
	} 
	m.Lists.Set(bucket.Name, bucket)
	return nil
}

func (m *TodosManager) AddTask(name string, newTask Task) error {
	name = strings.TrimSpace(name)
	todoList, found := m.Lists.Get(name)
	if !found {
		return errors.New("Todolist doesn't exists.")
	}

	t := todoList.(*TodoBucket)

	// check if caller owns bucket
	if std.GetOrigCaller() != t.Owner && !isAdmin(std.GetOrigCaller()) {
		return errors.New("You don't own this todolist")
	}

	t.Tasks = append(t.Tasks, newTask)
	return m.prepareAndSetBucket(t)
}

func (m *TodosManager) DeleteTask(bucketName string, taskName string) error {
	bucketName = strings.TrimSpace(bucketName)
	taskName = strings.TrimSpace(taskName)
	todoList, found := m.Lists.Get(bucketName)
	if !found {
		return errors.New("Todolist doesn't exists.")
	}
	t := todoList.(*TodoBucket)

	// check if caller owns bucket
	if std.GetOrigCaller() != t.Owner && !isAdmin(std.GetOrigCaller()) {
		return errors.New("You don't own this todolist")
	}

	// Remove the item in an atomically safe way
	tmp := make([]Task, 0)
	for _, v := range t.Tasks {
		if v.Name != taskName {
			tmp = append(tmp, v)
		}
	}
	t.Tasks = tmp

	return m.prepareAndSetBucket(t)
}

func (m *TodosManager) EditTask(bucketName string, taskName string, taskDesc string) error {
	bucketName = strings.TrimSpace(bucketName)
	taskName = strings.TrimSpace(taskName)
	todoList, found := m.Lists.Get(bucketName)
	if !found {
		return errors.New("Todolist doesn't exists.")
	}
	t := todoList.(*TodoBucket)

	// check if caller owns bucket
	if std.GetOrigCaller() != t.Owner && !isAdmin(std.GetOrigCaller()) {
		return errors.New("You don't own this todolist")
	}

	// Find and update item
	for i, v := range t.Tasks {
		if v.Name == taskName {
			t.Tasks[i].Name = taskName
			t.Tasks[i].Description = taskDesc
		}
	}

	return m.prepareAndSetBucket(t)
}

func (m *TodosManager) CompleteTask(bucketName string, taskName string) error {
	bucketName = strings.TrimSpace(bucketName)
	taskName = strings.TrimSpace(taskName)
	todoList, found := m.Lists.Get(bucketName)
	if !found {
		return errors.New("Todolist doesn't exists.")
	}
	t := todoList.(*TodoBucket)

	// check if caller owns bucket
	if std.GetOrigCaller() != t.Owner && !isAdmin(std.GetOrigCaller()) {
		return errors.New("You don't own this todolist")
	}

	// Find and update item
	for i, v := range t.Tasks {
		if v.Name == taskName {
			t.Tasks[i].Done = true
		}
	}

	return m.prepareAndSetBucket(t)
}

func (m *TodosManager) UncompleteTask(bucketName string, taskName string) error {
	bucketName = strings.TrimSpace(bucketName)
	taskName = strings.TrimSpace(taskName)
	todoList, found := m.Lists.Get(bucketName)
	if !found {
		return errors.New("Todolist doesn't exists.")
	}
	t := todoList.(*TodoBucket)

	// check if caller owns bucket
	if std.GetOrigCaller() != t.Owner && !isAdmin(std.GetOrigCaller()) {
		return errors.New("You don't own this todolist")
	}

	// Find and update item
	for i, v := range t.Tasks {
		if v.Name == taskName {
			t.Tasks[i].Done = false
		}
	}

	return m.prepareAndSetBucket(t)
}