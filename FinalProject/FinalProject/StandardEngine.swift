//
//  StandardEngine.swift
//  FinalProject
//
//  Created by Jack Ferrari on 8/1/16.
//  Copyright © 2016 Jack Ferrari. All rights reserved.
//

import UIKit

let notificationKey = "gridChanged"

class StandardEngine: EngineProtocol{
    
    private static var _standardSingleton = StandardEngine(rows: 10, cols: 10)
    static var standardSingleton: StandardEngine {
        get {
            return _standardSingleton
        }
    }
    
    var delegate: EngineDelegate?
    var grid: GridProtocol
    var rows: Int = 10 {
        didSet {
            grid = Grid(row: rows, col: cols)
            if delegate != nil {
                delegate!.engineDidUpdate(grid)
            }
        }
    }
    var cols: Int = 10 {
        didSet {
            grid = Grid(row: rows, col: cols)
            if delegate != nil {
                delegate!.engineDidUpdate(grid)
            }
        }
    }
    var refreshTimer: NSTimer!
    var refreshRate: Double = 0.0 {
        didSet{
            if refreshRate != 0 {
                refreshRate = 1/refreshRate
                if let refreshTimer = refreshTimer { refreshTimer.invalidate() }
                let sel = #selector(StandardEngine.timerDidFire(_:))
                refreshTimer = NSTimer.scheduledTimerWithTimeInterval(refreshRate,
                                                                      target: self,
                                                                      selector: sel,
                                                                      userInfo: nil,
                                                                      repeats: true)
            }
            else if let timer = refreshTimer {
                timer.invalidate()
                self.refreshTimer = nil
            }
        }
    }
    required init (rows: Int, cols: Int) {
        grid = Grid(row: rows, col: cols)
        self.rows = rows
        self.cols = cols
    }
    
    func step() -> GridProtocol {
        let newGrid = Grid(row: rows, col: cols)
        for h in 0..<grid.rows {
            for w in 0..<grid.cols {
                let cell: CellIndex = (h, w)
                let theNeighbors:[CellIndex]  = grid.neighbors(cell)
                var livingNeighbors = 0
                for i in 0..<theNeighbors.count{
                    if CellStates.alive(grid[theNeighbors[i].height, theNeighbors[i].width]) {
                        livingNeighbors+=1
                    }
                }
                switch grid[cell.height, cell.width] {
                case CellStates.Living, CellStates.Born:
                    if livingNeighbors == 2 || livingNeighbors == 3{
                        newGrid[cell.height, cell.width] = .Living
                    } else {
                        newGrid[cell.height, cell.width] = .Died
                    }
                case CellStates.Died, CellStates.Empty:
                    if livingNeighbors == 3 {
                        newGrid[cell.height, cell.width] = .Born
                    }
                    else {
                        newGrid[cell.height, cell.width] = .Empty
                    }
                }
            }
        }
        return newGrid
    }
    @objc func timerDidFire(timer:NSTimer) {
        grid = step()
        if (delegate != nil) {
            delegate!.engineDidUpdate(grid)
        }
    }
}
