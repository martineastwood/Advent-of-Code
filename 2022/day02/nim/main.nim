import std/strutils
import std/[times]
import tables


type
  Round = object
    p1, p2: string


var m = initTable[string, string]()
m["A"] = "Rock"
m["B"] = "Paper"
m["C"] = "Scissor"
m["X"] = "Rock"
m["Y"] = "Paper"
m["Z"] = "Scissor"


var points = initTable[string, int]()
points["Rock"] = 1
points["Paper"] = 2
points["Scissor"] = 3


proc p1_scoreRound(r: Round): int =
    var p1 = m[r.p1]
    var p2 = m[r.p2]
    
    var outcome: int = points[p2]

    if p1 == p2:
        outcome += 3

    case p2:
    of "Rock":
        if p1 == "Scissor":
            outcome += 6
    of "Paper":
        if p1 == "Rock":
            outcome += 6
    of "Scissor":
        if p1 == "Paper":
            outcome += 6
    else:
        echo "Unrecognized letter"        

    return outcome


proc p1(rounds: seq[Round]):int =
    var sum:int = 0
    for r in rounds:
        sum += p1_scoreRound(r)
    return sum


proc p2_scoreRound(r: Round): int =
    var p1 = m[r.p1]
    var p2 = r.p2

    var outcome: int = 0

    case p2:
    # Need to lose
    of "X":
        if p1 == "Rock":
            p2 = "Scissor"
        elif p1 == "Paper":
            p2 = "Rock"
        elif p1 == "Scissor":
            p2 = "Paper"
    # need to draw
    of "Y":
        outcome += 3
        if p1 == "Rock":
            p2 = "Rock"
        elif p1 == "Paper":
            p2 = "Paper"
        elif p1 == "Scissor":
            p2 = "Scissor"
    # need to win
    of "Z":
        outcome += 6
        if p1 == "Rock":
            p2 = "Paper"
        elif p1 == "Paper":
            p2 = "Scissor"
        elif p1 == "Scissor":
            p2 = "Rock"  

    outcome += points[p2]          

    return outcome


proc p2(rounds: seq[Round]):int =
    var sum:int = 0
    for r in rounds:
        sum += p2_scoreRound(r)
    return sum


let time = cpuTime()

let data = readFile("../input.txt").splitLines()

var rounds: seq[Round] = @[]
for item in data:
    var parts = item.split(" ")
    var round: Round
    round = Round(p1: parts[0], p2:parts[1])
    rounds.add(round)

echo "The solution to part 1 is: ", p1(rounds)
echo "The solution to part 1 is: ", p2(rounds)

echo "Time taken: ", (cpuTime() - time) * 1000, "ms"

# nim c -r -d:release -d:danger main.nim