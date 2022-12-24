import std/strutils
import std/[times, algorithm]

let time = cpuTime()

let data = readFile("../input.txt").splitLines()

var calories:int = 0
var vals: seq[int] = @[]

for value in data:
    if value == "":
        vals.add(calories)
        calories = 0
    else:
        calories += parseInt(value)

vals.sort()        

var p1 = vals[^1]
var p2 = vals[^1] + vals[^2] + vals[^3]

echo "The solution to part 1 is: ", p1
echo "The solution to part 2 is: ", p2

echo "Time taken: ", (cpuTime() - time) * 1000 * 1000, "µs"

# nim c -r -d:release -d:danger main.nim