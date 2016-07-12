//
//  GameManager.swift
//  Assignment3
//
//  Created by Jack Ferrari on 7/11/16.
//  Copyright © 2016 Jack Ferrari. All rights reserved.
//

import UIKit

typealias CellIndex = (height: Int, width: Int)

class GameManager {

    func neighbors(target: CellIndex, rows:Int, cols:Int) -> [CellIndex]?{
        //gets all coordinates and checks for wraping
        var incY = target.height+1
        var incX = target.width+1
        var decY = target.height-1
        var decX = target.width-1
        
        if incY == rows{
            incY = 0
        }
        if incX == cols {
            incX = 0
        }
        if decY < 0 {
            decY = rows - 1
        }
        if decX < 0 {
            decX = cols - 1
        }
        
        //builder of cells
        func returnCellIndex(y:Int, x:Int) -> CellIndex {
            var cell:CellIndex
            cell.height = y
            cell.width = x
            return cell
        }
        //final array of neighbor cells
        let Neighbors: Array<CellIndex> = [returnCellIndex(decY, x:decX), returnCellIndex(decY, x:target.width), returnCellIndex(decY, x:incX), returnCellIndex(target.height, x:decX), returnCellIndex(target.height, x:incX), returnCellIndex(incY, x:decX), returnCellIndex(incY, x:target.width), returnCellIndex(incY, x:incX)]
        return Neighbors
    }
    
    
    
    func step(original: Array<Array<CellStates>>, rows:Int, cols:Int) -> Array<Array<CellStates>> {
        var new = original
        for h in 0..<rows {
            for w in 0..<cols {
                var cell: CellIndex
                cell.height = h
                cell.width = w
                let theNeighbors:[CellIndex]  = neighbors(cell, rows: rows, cols: cols)!
                var livingNeighbors = 0
                for i in 0..<theNeighbors.count{
                    if original[theNeighbors[i].height][theNeighbors[i].width] == CellStates.Living||original[theNeighbors[i].height][theNeighbors[i].width] == CellStates.Born {
                        livingNeighbors+=1
                    }
                }
                switch new[cell.height][cell.width] {
                case .Living:
                    if livingNeighbors == 2 {
                        new[cell.height][cell.width] = .Living
                    }else if livingNeighbors == 3 {
                        new[cell.height][cell.width] = .Living
                    }else {
                        new[cell.height][cell.width] = .Died
                    }
                case .Born:
                    if livingNeighbors == 2 {
                        new[cell.height][cell.width] = .Living
                    } else if livingNeighbors == 3 {
                        new[cell.height][cell.width] = .Living
                    } else{
                        new[cell.height][cell.width] = .Died
                    }
                case .Died:
                    if livingNeighbors == 3 {
                        new[cell.height][cell.width] = .Born
                    }
                    else {
                        new[cell.height][cell.width] = .Empty
                    }
                case .Empty:
                    if livingNeighbors == 3 {
                        new[cell.height][cell.width] = .Born
                    }
                    else {
                        new[cell.height][cell.width] = .Empty
                    }
                }
            }
        }
        return new
    }
}
