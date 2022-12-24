import std/strutils
import std/[times, sets]
import sequtils


proc p1(data: seq[string], priorities: seq[char]): int =
    var sum: int = 0

    for item in data:
        var l: int = len(item) div 2
        var c1: string = item[0..l-1]
        var c2: string = item[l..^1]

        var a1 = toHashSet(toSeq(c1.items))
        var a2 = toHashSet(toSeq(c2.items))
        var i = intersection(a1, a2).toSeq[0]
        sum += (priorities.find(i) + 1)

    return sum


proc p2(data: seq[string], priorities: seq[char]): int =
    var sum:int = 0
    var counter: int = 0
    var history: array[3, string]

    for item in data:
        history[counter] = item
        counter += 1

        if counter == 3:
            var a1 = toHashSet(toSeq(history[0].items))
            var a2 = toHashSet(toSeq(history[1].items))
            var a3 = toHashSet(toSeq(history[2].items))

            var i1 = intersection(a1, a2)
            var i2 = intersection(i1, a3)
            var i3 = intersection(i1, i2)

            var i: char = i3.toSeq()[0]
            sum += (priorities.find(i) + 1)

            counter = 0

    return sum


let time = cpuTime()

let data = readFile("../input.txt").splitLines()

var priorities: seq[char] = @[]
for c in 'a'..'z':
    priorities.add(c)

for c in 'A'..'Z':
    priorities.add(c)    


echo "The solution to part 1 is: ", p1(data, priorities)
echo "The solution to part 2 is: ", p2(data, priorities)

echo "Time taken: ", (cpuTime() - time) * 1000, "ms"

# nim c -r -d:release -d:danger main.nim