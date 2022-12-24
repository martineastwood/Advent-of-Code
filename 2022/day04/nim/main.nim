import std/strutils
import std/[times]


type
  Pair = object
    start_point, end_point: int


proc p1(data: seq[string]): int=
    var sum: int = 0

    for item in data:
        var a, b: Pair

        var p1 = item.split(",")[0]
        a = Pair(start_point: parseInt(p1.split("-")[0]), end_point:parseInt(p1.split("-")[1]))

        var p2 = item.split(",")[1]
        b = Pair(start_point: parseInt(p2.split("-")[0]), end_point:parseInt(p2.split("-")[1]))

        if a.start_point <= b.start_point and a.end_point >= b.end_point:
            sum += 1
        elif b.start_point <= a.start_point and b.end_point >= a.end_point:
            sum += 1

    return sum


proc p2(data: seq[string]): int=
    var sum: int = 0

    for item in data:
        var a, b: Pair

        var p1 = item.split(",")[0]
        a = Pair(start_point: parseInt(p1.split("-")[0]), end_point:parseInt(p1.split("-")[1]))

        var p2 = item.split(",")[1]
        b = Pair(start_point: parseInt(p2.split("-")[0]), end_point:parseInt(p2.split("-")[1]))

        if a.start_point <= b.start_point and a.end_point >= b.start_point:
            sum += 1
        elif b.start_point <= a.start_point and b.end_point >= a.start_point:
            sum += 1

    return sum


# let time = cpuTime()
let t0 = epochTime()

let data = readFile("../input.txt").splitLines()

echo "The solution to part 1 is: ", p1(data)
echo "The solution to part 2 is: ", p2(data)

# echo "Time taken: ", (cpuTime() - time) * 1000, "ms"
let elapsed = (epochTime() - t0) * 1000
let elapsedStr = elapsed.formatFloat(format = ffDecimal, precision = 3)
echo "CPU Time: ", elapsedStr, "ms"

# nim c -r -d:release -d:danger main.nim