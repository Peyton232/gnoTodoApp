package markdown

import (
	"strings"
	"errors"

	"gno.land/p/demo/ufmt"
)

// ./build/gnokey maketx addpkg --pkgpath "gno.land/p/demo/markdown" -pkgdir "./p/markdown/" -gas-fee 50000000ugnot --gas-wanted 10000000 --broadcast --chainid dev --remote localhost:26657 g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5

type TableFormatter interface {
	Format(data [][]string) (string, error)
}

func newDefaultTableFormatter(headers []string) TableFormatter {
	return &defaultTableFormatter{
		config: &config{headers: headers},
	}
}

func newPrettyTableFormatter(headers []string) TableFormatter {
	return &prettyTableFormatter{
		config: &config{headers: headers},
	}
}

type defaultTableFormatter struct {
	config *config
}

func (formatter *defaultTableFormatter) Format(data [][]string) (string, error) {
	builder := &strings.Builder{}
	appendHeaders(builder, formatter.config.headers)
	for rowIndex, row := range data {
		if err := formatter.config.validateRow(rowIndex, row); err != nil {
			return "", err
		}
		builder.WriteString(joinValues(row))
	}
	return builder.String(), nil
}

type prettyTableFormatter struct {
	config *config
}

type prettyTable struct {
	widths  []int
	content [][]string
}

func (formatter *prettyTableFormatter) Format(data [][]string) (string, error) {
	prettyTable, err := formatter.preComputeFormattedData(data)
	if err != nil {
		return "", err
	}
	builder := &strings.Builder{}
	appendHeaders(builder, formatter.config.headers)
	for _, row := range prettyTable.content {
		builder.WriteString(joinValues(replacePadded(row, prettyTable.widths)))
	}
	return builder.String(), nil
}

func (formatter *prettyTableFormatter) preComputeFormattedData(data [][]string) (*prettyTable, error) {
	var widths []int
	for _, header := range formatter.config.headers {
		widths = append(widths, len(header))
	}
	for rowIndex, row := range data {
		if err := formatter.config.validateRow(rowIndex, row); err != nil {
			return nil, err
		}
		for columnIndex, cell := range row {
			cellLength := len(cell)
			if cellLength > widths[columnIndex] {
				widths[columnIndex] = cellLength
			}
		}
	}
	return &prettyTable{widths: widths, content: data}, nil
}

func appendHeaders(builder *strings.Builder, headers []string) {
	builder.WriteString(joinValues(headers))
	builder.WriteString(joinValues(replaceRepeated(headers, "-")))
}

type config struct {
	headers []string
}

func (config *config) validateRow(rowIndex int, row []string) error {
	headerCount := len(config.headers)
	rowLength := len(row)
	if rowLength != headerCount {
		return errors.New(ufmt.Sprintf("expected %d column(s), row number %d got %d", headerCount, 1+rowIndex, rowLength))
	}
	return nil
}

func joinValues(values []string) string {
	return ufmt.Sprintf("| %s |\n", strings.Join(values, " | "))
}

func replaceRepeated(items []string, replacementSymbol string) []string {
	var result []string
	for _, item := range items {
		result = append(result, strings.Repeat(replacementSymbol, len(item)))
	}
	return result
}

func replacePadded(items []string, widths []int) []string {
	var result []string
	for columnIndex, item := range items {
		format := ufmt.Sprintf("%%-%ds", widths[columnIndex])
		result = append(result, ufmt.Sprintf(format, item))
	}
	return result
}
