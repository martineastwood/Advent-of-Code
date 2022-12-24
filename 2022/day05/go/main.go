package main

import (
	"fmt"
	"io/ioutil"
	"regexp"
	"strconv"
	"strings"
	"time"
)

type crate []string
type Crate [9]crate

type instruction struct {
	n   int
	src int
	dst int
}

type Instructions []instruction

func loadData() (Crate, Instructions) {

	bs, _ := ioutil.ReadFile("../input.txt")
	input := strings.Split(string(bs), "\n")

	var crates Crate
	for i := 7; i >= 0; i-- {
		line := input[i]
		for j := 1; j < len(line); j += 4 {
			char := line[j : j+1]

			if char != " " {
				crateIdx := j / 4
				crates[crateIdx] = append(crates[crateIdx], char)
			}
		}
	}

	var instructions Instructions
	for i := 10; i < len(input); i++ {
		line := input[i]

		r := regexp.MustCompile(`\d+`)
		matches := r.FindAllString(line, -1)

		n, _ := strconv.Atoi(matches[0])
		src, _ := strconv.Atoi(matches[1])
		dst, _ := strconv.Atoi(matches[2])

		instr := instruction{n: n, src: src, dst: dst}

		instructions = append(instructions, instr)
	}

	return crates, instructions

}

func p1(crates Crate, instructions Instructions) []string {
	for _, instr := range instructions {
		for i := 0; i < instr.n; i++ {
			pop := crates[instr.src-1][len(crates[instr.src-1])-1]
			crates[instr.src-1] = crates[instr.src-1][:len(crates[instr.src-1])-1]
			crates[instr.dst-1] = append(crates[instr.dst-1], pop)
		}
	}

	output := []string{}
	for i := 0; i < len(crates); i++ {
		x := crates[i][len(crates[i])-1]
		output = append(output, x)
	}

	return output
}

func p2(crates Crate, instructions Instructions) []string {
	for _, instr := range instructions {
		items := []string{}
		for i := 0; i < instr.n; i++ {
			pop := crates[instr.src-1][len(crates[instr.src-1])-1]
			crates[instr.src-1] = crates[instr.src-1][:len(crates[instr.src-1])-1]
			items = append(items, pop)
		}

		for i := 0; i < instr.n; i++ {
			pop := items[len(items)-1]
			items = items[:len(items)-1]
			crates[instr.dst-1] = append(crates[instr.dst-1], pop)
		}
	}

	output := []string{}
	for i := 0; i < len(crates); i++ {
		x := crates[i][len(crates[i])-1]
		output = append(output, x)
	}

	return output
}

func main() {
	start := time.Now()

	crates, instructions := loadData()
	fmt.Println("The solution to part 1 is: ", p1(crates, instructions))

	crates, instructions = loadData()
	fmt.Println("The solution to part 2 is: ", p2(crates, instructions))

	end := time.Since(start)
	fmt.Println("Time: ", end)

}

// go run ../go/main.go
