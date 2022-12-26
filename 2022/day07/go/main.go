package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
	"time"
)

func getDirSizes(data []string) map[string]int {

	var path []string
	var slash string = "/"
	dirs := make(map[string]int)

	for _, instr := range data {
		parts := strings.Split(instr, " ")

		if parts[0] == "$" && parts[1] == "cd" && parts[2] == "/" {
			path = nil
			path = append(path, slash)
		} else if parts[0] == "$" && parts[1] == "cd" && parts[2] == ".." {
			path = path[:len(path)-1]
		} else if parts[0] == "$" && parts[1] == "cd" {
			path = append(path, parts[2]+slash)
		} else if parts[0] == "$" && parts[1] == "ls" {
			continue
		} else if parts[0] == "dir" {
			continue
		} else {
			size, _ := strconv.Atoi(parts[0])
			l := len(path)

			if size >= 0 {
				for i := l - 1; i >= 0; i-- {
					pth := strings.Join(path[0:i+1], "")
					_, ok := dirs[pth]
					if ok {
						dirs[pth] += size
					} else {
						dirs[pth] = size
					}

				}
			}
		}
	}

	return dirs
}

func p1(dirs map[string]int) int {
	var sum int = 0
	for _, val := range dirs {
		if val <= 100000 {
			sum += val
		}
	}
	return sum
}

func p2(dirs map[string]int) int {
	var min int = 999999999
	for _, val := range dirs {
		if dirs["/"]-val < 40000000 {
			if val < min {
				min = val
			}
		}
	}
	return min
}

func main() {
	start := time.Now()

	bs, _ := ioutil.ReadFile("../input.txt")
	input := strings.Split(string(bs), "\n")

	dirs := getDirSizes(input)

	fmt.Println(dirs)

	fmt.Println("The solution to part 1 is: ", p1(dirs))
	fmt.Println("The solution to part 2 is: ", p2(dirs))

	end := time.Since(start)
	fmt.Println("Time: ", end)

}

// go run ../go/main.go
