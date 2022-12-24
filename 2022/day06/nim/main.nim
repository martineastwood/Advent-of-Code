import std/strutils
import std/[times, deques, sets, sequtils]


proc p1(input: string, n: int): int =
    var mark = initDeque[char]()
    for i in countup(0, len(input) - 1):
        mark.addLast(input[i])

        if len(mark) == n and i != len(input) - 1:
            var s = toHashSet(mark.toSeq())

            if len(s) == n:
                return i + 1

            mark.popFirst()

    return -99


let t0 = epochTime()

let data = readFile("../input.txt").splitLines()[0]

echo "The solution to part 1 is: ", p1(data, 4)
echo "The solution to part 2 is: ", p1(data, 14)

let elapsed = (epochTime() - t0) * 1000
let elapsedStr = elapsed.formatFloat(format = ffDecimal, precision = 3)
echo "CPU Time: ", elapsedStr, "ms"

# nim c -r -d:release -d:danger main.nim