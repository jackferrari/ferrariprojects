//
//  SecondViewController.swift
//  Assignment4
//
//  Created by Jack Ferrari on 7/17/16.
//  Copyright © 2016 Jack Ferrari. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, EngineDelegate {
    let engine = StandardEngine.standardSingleton

    @IBOutlet var gridView: GridView!
    
    @IBAction func buttonPush(sender: AnyObject) {
        engine.grid = engine.step()
        gridView.grid = fillDisplay()
        engineDidUpdate(engine.grid)
        gridView.setNeedsDisplay()

    }
    @IBAction func toggleLife(sender: AnyObject) {
        let loc = sender.locationInView(gridView!)
        let x: Int = gridView.toggleStatusFromLoc(loc.x, yloc: loc.y).x
        let y :Int = gridView.toggleStatusFromLoc(loc.x, yloc: loc.y).y
        gridView.grid[x][y] = CellStates.toggle(gridView.grid[x][y])
        engine.grid[x, y] = CellStates.toggle(engine.grid[x, y])
        engineDidUpdate(engine.grid)
        gridView.setNeedsDisplay()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        engine.delegate = self
        engineDidUpdate(engine.grid)
    }
    
    func fillDisplay () -> [[CellStates]]{
        var temp = gridView.grid
        for h in 0..<gridView.rows {
            for w in 0..<gridView.cols {
                temp[h][w] = StandardEngine.standardSingleton.grid[h, w]
            }
        }
        return temp
    }
    
    func watchForNotifications(notification:NSNotification) {
        engineDidUpdate(StandardEngine.standardSingleton.grid)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getStats(checkedGrid: GridProtocol) -> (liv: Int, die: Int, bor: Int, Emp: Int) {
        var hold: Array<CellStates> = Array(count: checkedGrid.rows*checkedGrid.cols, repeatedValue:
                                                                                    CellStates.Empty)
        for h in 0..<checkedGrid.rows {
            for w in 0..<checkedGrid.cols {
                hold[checkedGrid.cols * h + (w)] = checkedGrid[h, w]
            }
        }
        let living = countType(CellStates.Living, grid: hold)
        let born = countType(CellStates.Born, grid: hold)
        let died = countType(CellStates.Died, grid: hold)
        let empty = countType(CellStates.Empty, grid: hold)
        return (liv: living, die: died, bor: born, Emp: empty)
    }
    
    func countType(type: CellStates, grid:[CellStates]) -> Int {
        return grid.reduce(0) { return $1 == type ? $0+1 : $0 }
    }

    func engineDidUpdate(withGrid: GridProtocol) {
        let gridInstance = Grid(row: withGrid.rows, col: withGrid.cols)
        for h in 0..<withGrid.rows {
            for w in 0..<withGrid.cols {
                gridInstance[h, w] = withGrid[h, w]
            }
        }
        if gridView == nil {
            self.gridView = GridView()
        }
        gridView.rows = withGrid.rows
        gridView.cols = withGrid.cols
        for h in 0..<gridView.rows {
            for w in 0..<gridView.cols {
                gridView.grid[h][w] = withGrid[h, w]
            }
        }
        gridView.setNeedsDisplay()
        NSNotificationCenter.defaultCenter().postNotificationName(notificationKey, object: nil, userInfo: ["living" : getStats(withGrid).liv,
             "born"   : getStats(withGrid).bor,
             "died"   : getStats(withGrid).die,
             "empty"  : getStats(withGrid).Emp
            ])
    }
}

