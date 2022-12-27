package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
	"time"
)

func loadInput(path string) [][]int {
	bs, _ := ioutil.ReadFile(path)
	input := strings.Split(string(bs), "\n")

	var output [][]int

	for i := 0; i < len(input); i++ {
		var row []int
		for j := 0; j < len(input[i]); j++ {
			tmp := string(input[i][j])
			i, _ := strconv.Atoi(tmp)
			row = append(row, i)
		}
		output = append(output, row)
	}

	return output
}

func p1(data [][]int) int {
	var n_rows = len(data)
	var n_cols = len(data[0])
	var visible []int

	for i := 0; i < n_rows; i++ {
		var row []int = data[i]

		for j := 0; j < n_cols; j++ {
			var col []int
			for k := 0; k < n_cols; k++ {
				col = append(col, data[k][j])
			}

			// add exterior
			if i == 0 || i == n_rows-1 {
				visible = append(visible, data[i][j])
				continue
			}

			if j == 0 || j == n_cols-1 {
				visible = append(visible, data[i][j])
				continue
			}

			// check left
			visible_left := true
			for k := 0; k < j; k++ {
				if row[k] >= row[j] {
					visible_left = false
					break
				}
			}

			// check right
			visible_right := true
			for k := j + 1; k < n_cols; k++ {
				if row[k] >= row[j] {
					visible_right = false
					break
				}
			}

			// check up
			visible_up := true
			for k := 0; k < i; k++ {
				if col[k] >= row[j] {
					visible_up = false
					break
				}
			}

			// check down
			visible_down := true
			for k := i + 1; k <= n_cols-1; k++ {
				if col[k] >= row[j] {
					visible_down = false
					break
				}
			}

			if visible_left || visible_right || visible_up || visible_down {
				visible = append(visible, data[i][j])
			}

		}
	}

	return len(visible)
}

func p2(dirs map[string]int) int {
	var min int = 999999999

	return min
}

func main() {
	start := time.Now()

	input := loadInput("../input.txt")

	fmt.Println("The solution to part 1 is: ", p1(input))
	// fmt.Println("The solution to part 2 is: ", p2(dirs))

	end := time.Since(start)
	fmt.Println("Time: ", end)

}

// go run ../go/main.go
