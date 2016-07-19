//
//  Grid.swift
//  Assignment4
//
//  Created by Jack Ferrari on 7/17/16.
//  Copyright © 2016 Jack Ferrari. All rights reserved.
//

import UIKit

class Grid: GridProtocol {
    
    var rows: Int
    var cols: Int
    var grid: Array<Array<CellStates>> = [[]]
    
    required init(row:Int, col:Int){
        rows = row
        cols = col
        grid = Array(count: rows, repeatedValue: Array(count: cols, repeatedValue: CellStates.Empty))
    }
    
    let offsets:[CellIndex] = [(-1,-1), (-1, 0), (-1, 1),
                              ( 0,-1),          ( 0, 1),
                              ( 1,-1), ( 1, 0), ( 1, 1)
    ]
    
    
    func neighbors(pos: CellIndex) -> [CellIndex] {
        return offsets.map { ((pos.height + rows + $0.height) % rows, (pos.width + cols + $0.width) % cols) }
    }
    
    subscript(row: Int, col: Int) -> CellStates {
        get {
            return grid[row][col]
        }
        set (newValue){
            if row < 0 || row >= rows || col < 0 || col >= cols {
                return
            }
            grid[row][col] = newValue
        }
    }
}
