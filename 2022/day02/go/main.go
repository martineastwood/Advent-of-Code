package main

import (
	"fmt"
	"io/ioutil"
	"strings"
	"time"
)

var m = map[string]string{
	"A": "Rock",
	"B": "Paper",
	"C": "Scissor",
	"X": "Rock",
	"Y": "Paper",
	"Z": "Scissor",
}

var points = map[string]int{
	"Rock":    1,
	"Paper":   2,
	"Scissor": 3,
}

type Round struct {
	P1 string
	P2 string
}

func p1_scoreRound(r Round) int {
	p1 := m[r.P1]
	p2 := m[r.P2]

	var outcome int = points[p2]

	if p1 == p2 {
		outcome += 3
	}

	switch p2 {
	case "Rock":
		if p1 == "Scissor" {
			outcome += 6
		}
	case "Paper":
		if p1 == "Rock" {
			outcome += 6
		}
	case "Scissor":
		if p1 == "Paper" {
			outcome += 6
		}
	}

	return outcome
}

func p2_scoreRound(r Round) int {
	p1 := m[r.P1]
	p2 := r.P2

	var outcome int = 0

	switch p2 {
	// need to lose
	case "X":
		if p1 == "Rock" {
			p2 = "Scissor"
		} else if p1 == "Paper" {
			p2 = "Rock"
		} else if p1 == "Scissor" {
			p2 = "Paper"
		}
	// need to draw
	case "Y":
		outcome += 3
		if p1 == "Rock" {
			p2 = "Rock"
		} else if p1 == "Paper" {
			p2 = "Paper"
		} else if p1 == "Scissor" {
			p2 = "Scissor"
		}
		// need to win
	case "Z":
		outcome += 6
		if p1 == "Rock" {
			p2 = "Paper"
		} else if p1 == "Paper" {
			p2 = "Scissor"
		} else if p1 == "Scissor" {
			p2 = "Rock"
		}
	}

	outcome += points[p2]

	return outcome
}

func p1(rounds []Round) int {
	var sum int = 0

	for i := range rounds {
		sum += p1_scoreRound(rounds[i])
	}

	return sum
}

func p2(rounds []Round) int {
	var sum int = 0

	for i := range rounds {
		sum += p2_scoreRound(rounds[i])
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

	// parse the input by round
	var rounds []Round
	for i := range input {
		parts := strings.Split(input[i], " ")
		round := Round{P1: parts[0], P2: parts[1]}
		rounds = append(rounds, round)
	}

	fmt.Println("The solution to part 1 is: ", p1(rounds))
	fmt.Println("The solution to part 2 is: ", p2(rounds))

	end := time.Since(start)
	fmt.Println("Time: ", end)

}

// go run ../go/main.go
