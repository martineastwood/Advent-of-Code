package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
	"time"
)

type pair struct {
	start_point int
	end_point   int
}

func p1(data []string) int {
	var sum int = 0

	for _, item := range data {
		p1 := strings.Split(item, ",")[0]
		p2 := strings.Split(item, ",")[1]

		p1a, _ := strconv.Atoi(strings.Split(p1, "-")[0])
		p1b, _ := strconv.Atoi(strings.Split(p1, "-")[1])
		a := pair{start_point: p1a, end_point: p1b}

		p2a, _ := strconv.Atoi(strings.Split(p2, "-")[0])
		p2b, _ := strconv.Atoi(strings.Split(p2, "-")[1])
		b := pair{start_point: p2a, end_point: p2b}

		if a.start_point <= b.start_point && a.end_point >= b.end_point {
			sum += 1
		} else if b.start_point <= a.start_point && b.end_point >= a.end_point {
			sum += 1
		}
	}

	return sum
}

func p2(data []string) int {
	var sum int = 0

	for _, item := range data {
		p1 := strings.Split(item, ",")[0]
		p2 := strings.Split(item, ",")[1]

		p1a, _ := strconv.Atoi(strings.Split(p1, "-")[0])
		p1b, _ := strconv.Atoi(strings.Split(p1, "-")[1])
		a := pair{start_point: p1a, end_point: p1b}

		p2a, _ := strconv.Atoi(strings.Split(p2, "-")[0])
		p2b, _ := strconv.Atoi(strings.Split(p2, "-")[1])
		b := pair{start_point: p2a, end_point: p2b}

		if a.start_point <= b.start_point && a.end_point >= b.start_point {
			sum += 1
		} else if b.start_point <= a.start_point && b.end_point >= a.start_point {
			sum += 1
		}
	}

	return sum
}

func main() {
	start := time.Now()

	// load the data into a slice of strings
	bs, err := ioutil.ReadFile("../input.txt")

	if err != nil {
		bs, _ = ioutil.ReadFile("../input.txt")
	}

	input := strings.Split(string(bs), "\n")

	fmt.Println("The solution to part 1 is: ", p1(input))
	fmt.Println("The solution to part 2 is: ", p2(input))

	end := time.Since(start)
	fmt.Println("Time: ", end)

}

// go run ../go/main.go
