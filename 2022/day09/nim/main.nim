import std/strutils
import std/sets
import std/math
import std/times


type
  Coord = tuple
    x: int 
    y: int

  Instruction = object
    direction: string
    distance: int  


proc loadData(filepath:string): seq[Instruction] =
    for line in readFile(filepath).splitLines():
        var tmp = line.split(" ")
        result.add(Instruction(direction: tmp[0], distance: parseInt(tmp[1])))
    return result


proc is_adjacent(a: Coord, b: Coord): bool =
  let dx = a.x - b.x
  let dy = a.y - b.y
  result = abs(dx) <= 1 and abs(dy) <= 1


proc move(instr: Instruction, head_pos: var Coord, tail_pos:var Coord, history: var seq[Coord]): (Coord, Coord, seq[Coord]) = 
    var change: Coord
    change = (x: 0, y:0)  

    if instr.direction == "U":
        change = (x: 0, y: 1)
    elif instr.direction == "D":
        change = (x: 0, y: -1)
    elif instr.direction == "R":
        change = (x: 1, y: 0)  
    elif instr.direction == "L":
        change = (x: -1, y: 0)                
    else: 
        change = (x: 0, y: 0)

    for i in 0..instr.distance-1:
        head_pos.x += change.x
        head_pos.y += change.y

        if not is_adjacent(head_pos, tail_pos):
            if head_pos.x == tail_pos.x or head_pos.y == tail_pos.y:
                tail_pos.x += change.x
                tail_pos.y += change.y
                history.add(tail_pos)
            else:
                var diff: Coord 
                diff = (x: head_pos.x - tail_pos.x, y: head_pos.y - tail_pos.y)
                diff.x = sgn(diff.x)
                diff.y = sgn(diff.y)

                tail_pos.x += diff.y
                tail_pos.y += diff.x
                history.add(tail_pos)
        else:
            history.add(tail_pos)

    return (head_pos, tail_pos, history)


proc move_knot(direction: string): Coord =
    var dir: Coord

    if direction == "U":
        dir = (x: 0, y: 1)
    elif direction == "D":
        dir = (x: 0, y: -1)
    elif direction == "R":
        dir = (x: 1, y: 0)  
    elif direction == "L":
        dir = (x: -1, y: 0)                
    else: 
        dir = (x: 0, y: 0)

    return dir    


proc move_tail(head: Coord, tail: var Coord): Coord =
    var dx = head.x - tail.x
    var dy = head.y - tail.y

    if abs(dx) <= 1 and abs(dy) <= 1:
        return tail
    elif dx == 0:
        tail.y = tail.y + dy div abs(dy)
        return tail
    elif dy == 0:
        tail.x = tail.x + dx div abs(dx)
        return tail  
    else:
        tail.x += dx div abs(dx)
        tail.y += dy div abs(dy)
        return tail


proc p1(data:seq[Instruction]): int =   
    var head, tail: Coord
    head = (x: 0, y:0)
    tail = (x: 0, y:0)

    var history: seq[Coord]

    for instr in data:
        for i in countup(0, instr.distance-1):
            var dir = move_knot(instr.direction)
            head.x += dir.x
            head.y += dir.y

            tail = move_tail(head, tail)
            history.add(tail)

    return len(toHashSet(history))


proc p2(data:seq[Instruction]): int =   
    var knot: Coord
    knot = (x: 0, y:0)

    var knots: seq[Coord]
    for i in countup(0, 9):
        knots.add(knot)

    var history: seq[Coord]

    for instr in data:
        for i in countup(0, instr.distance-1):
            var dir = move_knot(instr.direction)
            knots[0].x += dir.x
            knots[0].y += dir.y

            for j in countup(1, len(knots)-1):
                knots[j] = move_tail(knots[j-1], knots[j])
            history.add(knots[^1])

    return len(toHashSet(history))

let t0 = epochTime()

let data = loadData("../input.txt")

echo "The solution to part 1 is: ", p1(data)
echo "The solution to part 2 is: ", p2(data)      

let elapsed = (epochTime() - t0) * 1000
let elapsedStr = elapsed.formatFloat(format = ffDecimal, precision = 3)
echo "CPU Time: ", elapsedStr, "ms"

# nim c -r -d:release -d:danger main.nim 