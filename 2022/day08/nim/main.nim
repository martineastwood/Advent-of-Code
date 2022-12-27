import std/strutils
import std/sequtils
import std/[times, tables]


proc loadData(filepath:string): seq[seq[int]] =
    for line in readFile(filepath).splitLines():
        result.add(line.mapIt(parseInt($it)))    
    return result
    

proc p1(data:seq[seq[int]]): int =
    let n_rows = len(data)
    let n_cols = len(data[0])
    var visible: seq[int]

    for i in countup(0, n_rows - 1):
        var row = data[i]

        for j in countup(0, n_cols - 1):
            var col: seq[int]
            for k in countup(0, n_cols - 1):
                col.add(data[k][j])

            # add exterior
            if i == 0 or i == n_rows - 1:
                visible.add(data[i][j])
                continue

            if j == 0 or j == n_cols - 1:
                visible.add(data[i][j])
                continue

            # check left
            var visible_left = true
            for k in countup(0, j-1):
                if row[k] >= row[j]:
                    visible_left = false
                    break

            # check right
            var visible_right = true
            for k in countup(j+1, n_cols - 1):
                if row[k] >= row[j]:
                    visible_right = false     
                    break

            # check up
            var visible_up = true
            for k in countup(0, i - 1):
                if col[k] >= data[i][j]:
                    visible_up = false    
                    break     

            var visible_down = true
            for k in countup(i + 1, n_cols - 1):
                if col[k] >= data[i][j]:
                    visible_down = false    
                    break

            if visible_left or visible_right or visible_down or visible_up:
                visible.add(data[i][j])                                      

    return len(visible)


proc p2(data:seq[seq[int]]): int =
    let n_rows = len(data)
    let n_cols = len(data[0])

    var scores: seq[float]

    for i in countup(0, n_rows - 1):
        for j in countup(0, n_cols - 1):

            var up = 0.0
            for k in countdown(i - 1, 0):
                up += 1
                if data[k][j] >= data[i][j]:
                    break   

            var down = 0.0
            for k in countup(i + 1, n_rows - 1):
                down += 1
                if data[k][j] >= data[i][j]:
                    break     

            var left = 0.0
            for k in countdown(j - 1, 0):
                left += 1
                if data[i][k] >= data[i][j]:
                    break   

            var right = 0.0
            for k in countup(j + 1, n_cols - 1):
                right += 1
                if data[i][k] >= data[i][j]:
                    break                   

            scores.add(up * down * left * right)

    return max(scores).toInt


let t0 = epochTime()

let data = loadData("../input.txt")

echo "The solution to part 1 is: ", p1(data)
echo "The solution to part 2 is: ", p2(data)      

let elapsed = (epochTime() - t0) * 1000
let elapsedStr = elapsed.formatFloat(format = ffDecimal, precision = 3)
echo "CPU Time: ", elapsedStr, "ms"

# nim c -r -d:release -d:danger main.nim 