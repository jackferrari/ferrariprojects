//: Playground - noun: a place where people can play

import UIKit
var rows = 10
var cols = 10

typealias Position = (row: Int, col: Int)


let offsets:[Position] = [(-1,-1), (-1, 0), (-1, 1),
                          ( 0,-1),          ( 0, 1),
                          ( 1,-1), ( 1, 0), ( 1, 1)
]


func neighbors(pos: Position) -> [Position] {
    return offsets.map { ((pos.row + rows + $0.row) % rows, (pos.col + cols + $0.col) % cols) }
}

typealias CellState = Bool
typealias Cell = (position:Position, alive:CellState)

let numCells = rows*cols
var grid = (0..<numCells).map {
    (($0/cols, $0%cols), arc4random_uniform(3) == 1) as Cell
}

grid

func countLiving(grid:[Cell]) -> Int {
    return grid.reduce(0) { return $1.alive ? $0+1 : $0 }
}

countLiving(grid)

func countLivingNeighbors(grid:[Cell], cell:Cell) -> Int {
    return neighbors((cell.position.row, cell.position.col))
        .reduce(0) { grid[$1.row*cols + $1.col].alive ? $0 + 1 : $0 }
}

func step(grid:[Cell]) -> [Cell] {
    return grid.map {
        switch countLivingNeighbors(grid, cell: $0) {
        case 3, 2 where  $0.alive: return ($0.position, true)
        default: return ($0.position, false)
        }
    }
}
