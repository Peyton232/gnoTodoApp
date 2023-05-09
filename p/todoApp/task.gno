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

type Task struct {
	Done bool
	Name string 
	Description string
} 

// for debugging purposes
func (t *Task) renderTask() string {
	condition := "incomplete"
	if t.Done {
		condition = "complete"
	}
	return "*" + condition + "\t\t" + t.Name + "\n" + t.Description + "\n\n\n"
}

func (t *Task) taskItems(prefix string, bucketName string) []string {
	trimedPrefix := prefix[:len(prefix)-1]
	params := "&bucketName=" +  strings.Replace(bucketName, " ", "%20", -1) + "&taskName=" + strings.Replace(t.Name, " ", "%20", -1)
	condition := ufmt.Sprintf("[%s](%s)", "Incomplete", trimedPrefix + "?help&__func=CompleteTask" + params)
   	if t.Done {
		condition = ufmt.Sprintf("[%s](%s)", "Complete", trimedPrefix + "?help&__func=UncompleteTask" + params)
	}
	return []string{condition, "  " + t.Name + "  \\", "  " + t.Description + "  \\", ufmt.Sprintf("[%s](%s)", "Edit", trimedPrefix + "?help&__func=EditTask" + params)}
}