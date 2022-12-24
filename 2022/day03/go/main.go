package main

import (
	"fmt"
	"io/ioutil"
	"strings"
	"time"
)

func p1(data []string, priorities_str string) int {
	var sum int = 0
	for _, rucksack := range data {
		var l = len(rucksack) / 2
		var c1 = rucksack[:l]
		var c2 = rucksack[l:]

		for i := 0; i < len(c1); i++ {
			char := string(c1[i])
			exists := strings.Contains(c2, char)

			if exists {
				idx := strings.Index(priorities_str, char)
				sum += idx + 1
				break
			}
		}
	}

	return sum
}

func p2(data []string, priorities_str string) int {
	var sum int = 0
	var counter int = 0
	var history = [3]string{}

	for _, item := range data {
		history[counter] = item
		counter += 1

		if counter == 3 {
			counter = 0

			for i := 0; i < len(history[0]); i++ {
				c1 := string(history[0][i])

				exists_in_2 := strings.Contains(history[1], c1)

				if exists_in_2 {
					exists_in_3 := strings.Contains(history[2], c1)

					if exists_in_3 {
						idx := strings.Index(priorities_str, c1)
						sum += (idx + 1)
						break
					}
				}
			}
		}
	}

	return sum
}

func main() {
	start := time.Now()

	priorities_str := "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

	// load the data into a slice of strings
	bs, err := ioutil.ReadFile("../input.txt")

	if err != nil {
		bs, _ = ioutil.ReadFile("../input.txt")
	}

	input := strings.Split(string(bs), "\n")

	fmt.Println("The solution to part 1 is: ", p1(input, priorities_str))
	fmt.Println("The solution to part 2 is: ", p2(input, priorities_str))

	end := time.Since(start)
	fmt.Println("Time: ", end)

}

// go run ../go/main.go
