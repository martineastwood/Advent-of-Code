// package main

// import (
// 	"fmt"
// 	"io/ioutil"
// 	"strings"
// 	"time"
// )

// func p1(data string, n int) int {

// 	var mark []string

// 	for i := 0; i < len(data); i++ {
// 		var x string = string(data[i])

// 		mark = append(mark, x)

// 		if len(mark) == n && i != len(data)-1 {
// 			set := map[string]bool{}

// 			for j := 0; j < n; j++ {
// 				set[mark[j]] = true
// 			}

// 			if len(set) == n {
// 				return i + 1
// 			}

// 			mark = mark[1:n]
// 		}
// 	}

// 	return -99
// }

// func main() {
// 	start := time.Now()

// 	bs, _ := ioutil.ReadFile("../input.txt")
// 	input := strings.Split(string(bs), "\n")[0]

// 	fmt.Println("The solution to part 1 is: ", p1(input, 4))
// 	fmt.Println("The solution to part 2 is: ", p1(input, 14))

// 	end := time.Since(start)
// 	fmt.Println("Time: ", end)

// }

// // go run ../go/main.go
