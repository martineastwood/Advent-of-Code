import std/strutils
import std/[times, tables]


proc seqToString(s: seq[string]): string =
    var str:string = ""
    for x in s:
        str = str & x   
    return str

proc getDirSizes(data:seq[string]): Table[string, int] =
    var path: seq[string]
    var slash: string = "/"
    var dirs = initTable[string, int]()

    for instr in data:
        var parts = instr.split(" ")
        if parts[0] == "$" and parts[1] == "cd" and parts[2] == "/":
            path.setLen(0)
            path.add(slash)
        elif parts[0] == "$" and parts[1] == "cd" and parts[2] == "..":
            discard path.pop()
        elif parts[0] == "$" and parts[1] == "cd":        
            path.add(parts[2] & slash)
        elif parts[0] == "$" and parts[1] == "ls":
            continue
        elif parts[0] == "dir":
            continue
        else:
            var size = parseInt(parts[0])
            var l = len(path)

            for i in countdown(l-1, 0):
                var pth = seqToString(path[0..i])
                if dirs.hasKey(pth):
                    dirs[pth] += size
                else:
                    dirs[pth] = size
    return dirs


proc p1(dirs:Table[string, int]): int =
    var sum:int = 0
    for key, val in dirs.pairs:
        if val <= 100_000:
            sum += val
    return sum


proc p2(dirs:Table[string, int]): int =
    var min:int = 99999999
    for key, val in dirs.pairs:
        if dirs["/"] - val < 40_000_000:
            if val < min:
                min = val
    return min


let t0 = epochTime()

let data = readFile("../input.txt").splitLines()

var dirs = getDirSizes(data)

echo "The solution to part 1 is: ", p1(dirs)
echo "The solution to part 2 is: ", p2(dirs)      

let elapsed = (epochTime() - t0) * 1000
let elapsedStr = elapsed.formatFloat(format = ffDecimal, precision = 3)
echo "CPU Time: ", elapsedStr, "ms"

# nim c -r -d:release -d:danger main.nim 