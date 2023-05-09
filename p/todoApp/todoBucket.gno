package todo

import (
	"errors"
	"std"
	"strconv"
	"strings"
	"time"

	"gno.land/p/demo/avl"
	"gno.land/p/demo/ufmt"
	"gno.land/p/demo/markdown"
)

type TodoBucket struct {
	Name string
	Prefix string
	Owner std.Address
	Tasks []Task
}

func (b *TodoBucket) RenderListItem() string {
	output := ""
	if b == nil {
		return "error: no such todo list for user\n"
	}
	output += ufmt.Sprintf("## [&#9656; %s list](%s)\n", b.Name, b.URL())
	output += "\n"

	return output
}

func (b *TodoBucket) URL() string {
	if b == nil {
		return b.Prefix + "404"
	}
	return b.Prefix + "p/" + b.Name
}

func (b *TodoBucket) renderTaskList(prefix string) string {
	trimmedPrefix := prefix[:len(prefix)-1]
	if len(b.Tasks) < 1 {
		return ufmt.Sprintf("[%s](%s)", "There are no tasks here, click to add one", trimmedPrefix + "?help&__func=AddTask" + "&bucketName=" +  strings.Replace(b.Name, " ", "%20", -1))
	}

	taskList := make([][]string, 0)
	for _, v := range b.Tasks {
		taskList = append(taskList, v.taskItems(prefix, b.Name))
	} 

	table, err := markdown.NewTableFormatterBuilder().
	Build("State", "Name", "Description", "----").
	Format(taskList)

	table += "\n\n\n"
	table += ufmt.Sprintf("[%s](%s)", "Add more tasks", trimmedPrefix + "?help&__func=AddTask" + "&bucketName=" +  strings.Replace(b.Name, " ", "%20", -1))

	return table
}
