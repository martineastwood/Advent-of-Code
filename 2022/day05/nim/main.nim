import std/strutils
import std/[times]
import re


type
    Crate = seq[char]
    Crates = array[9, Crate]

    Instruction = object
        n: int
        src: int
        dst: int

    Instructions = seq[Instruction]


proc loadData(): (Crates, Instructions) = 
    let data = readFile("../input.txt").splitLines()

    var crates: Crates

    for i in countdown(7, 0):
        let line = data[i]
        for col in countup(1, 35, 4):
            let crateIdx = col div 4
            let val = line[col]
            if val != ' ':
                crates[crateIdx].add(val)

    var instructions: Instructions

    for i in countup(10, data.high):
        let ints = findAll(data[i], re"\d+", start=1)

        let instr = Instruction(
            n : parseInt(ints[0]),
            src : parseInt(ints[1]),
            dst : parseInt(ints[2])
        )

        instructions.add(instr)

    return (crates, instructions)



proc p1(crates: var Crates, instructions: Instructions): seq[char] =
    for instr in instructions:
        for i in 0..instr.n - 1:
            crates[instr.dst - 1].add(pop(crates[instr.src - 1]))
    
    var output: seq[char]
    for i in crates:
        output.add(i[^1])

    return output


proc p2(crates: var Crates, instructions: Instructions): seq[char] =
    for instr in instructions:
        
        var items: seq[char]
        for i in 0..instr.n - 1:
            items.add(pop(crates[instr.src - 1]))

        for i in 0..instr.n - 1:
            crates[instr.dst - 1].add(pop(items))

    var output: seq[char]
    for i in crates:
        output.add(i[^1])

    return output


let t0 = epochTime()

var (crates, instructions) = loadData()
echo "The solution to part 1 is: ", p1(crates, instructions)

(crates, instructions) = loadData()
echo "The solution to part 2 is: ", p2(crates, instructions)

let elapsed = (epochTime() - t0) * 1000
let elapsedStr = elapsed.formatFloat(format = ffDecimal, precision = 3)
echo "CPU Time: ", elapsedStr, "ms"

# nim c -r -d:release -d:danger main.nim