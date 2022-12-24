package main

import (
	"fmt"
	"io/ioutil"
	"sort"
	"strconv"
	"strings"
	"time"
)

func main() {
	start := time.Now()

	// load the data into a slice of strings
	bs, err := ioutil.ReadFile("../input.txt")

	if err != nil {
		bs, _ = ioutil.ReadFile("../input.txt")
	}

	input := strings.Split(string(bs), "\n")

	// sum the calories per elf as ints
	// elves are split by blank lines
	var vals []int
	var c int = 0
	for _, value := range input {
		if value == "" {
			vals = append(vals, c)
			c = 0
		}
		val, _ := strconv.Atoi(value)
		c += val
	}

	// sort the slice
	sort.Sort(sort.IntSlice(vals))

	// part one is just the max of the slice
	var p1 = vals[len(vals)-1]

	// part two is the sum of the top 3 elves
	var p2 int = 0
	for i := 0; i < 3; i++ {
		p2 += vals[len(vals)-1-i]
	}

	fmt.Println("The solution to part 1 is: ", p1)
	fmt.Println("The solution to part 2 is: ", p2)

	end := time.Since(start)
	fmt.Println("Time: ", end)

}

// go run ../go/main.go
