package gnotasks 

import (
	"std"
	"strings"

	"gno.land/p/demo/avl"
	logic "gno.land/p/todoapp"
)

var (
	adminAddr     std.Address
	moderatorList avl.Tree
	inPause       bool
)

func AddBucket(bucketName string) string {
	err := m.AddBucket(bucketName)
	if err != nil {
		return err.Error()
	}
	return "success"
}

func AddTask(bucketName string, taskName string, taskDesc string) string {
	err := m.AddTask(bucketName, logic.Task{Done: false, Name: taskName, Description: taskDesc})
	if err != nil {
		return err.Error()
	}
	return "success"
}

func DeleteTask(bucketName string, taskName string) string {
	err := m.DeleteTask(bucketName, taskName)
	if err != nil {
		return err.Error()
	}
	return "success"
}

func EditTask(bucketName string, taskName string, taskDesc string) string {
	err := m.EditTask(bucketName, taskName, taskDesc)
	if err != nil {
		return err.Error()
	}
	return "success"
}

func CompleteTask(bucketName string, taskName string) string {
	err := m.CompleteTask(bucketName, taskName)
	if err != nil {
		return err.Error()
	}
	return "success"
}

func UncompleteTask(bucketName string, taskName string) string {
	err := m.UncompleteTask(bucketName, taskName)
	if err != nil {
		return err.Error()
	}
	return "success"
}
