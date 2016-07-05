//
//  ViewController.swift
//  Assignment2
//
//  Created by Jack Ferrari on 7/4/16.
//  Copyright © 2016 Jack Ferrari. All rights reserved.
//

import UIKit

class Problem2ViewController: UIViewController {
    
    @IBOutlet weak var result: UITextView!
    
    @IBAction func clicked(sender: UIButton) {
        let before = Engine(height: 10, width: 10)
        var stringToBeResult = ""
        stringToBeResult += "total population before: \(before.getPopulation())"
        stringToBeResult += "\n"
        var after = before
        for h in 0..<after.height{
            for w in 0..<after.width{
                //gets all coordinates and checks for wraping
                var incY = h+1
                var incX = w+1
                var decY = h-1
                var decX = w-1
                
                if incY == after.height{
                    incY = 0
                }
                if incX == after.width {
                    incX = 0
                }
                if decY < 0 {
                    decY = after.height - 1
                }
                if decX < 0 {
                    decX = after.width - 1
                }
                
                //builder of cells
                func returnCellIndex(y:Int, x:Int) -> CellIndex {
                    var cell:CellIndex
                    cell.height = y
                    cell.width = x
                    return cell
                }
                
                //final array of neighbor cells
                let neighbors: Array<CellIndex> = [returnCellIndex(decY, x:decX), returnCellIndex(decY, x:w), returnCellIndex(decY, x:incX), returnCellIndex(h, x:decX), returnCellIndex(h, x:incX), returnCellIndex(incY, x:decX), returnCellIndex(incY, x:w), returnCellIndex(incY, x:incX)]
                var livingNeighbors = 0
                for w in 0..<neighbors.count{
                    let width = neighbors[w].width
                    let height = neighbors[w].height
                    if after.twoDimentionalArrayOfBools[height][width] == true{
                        livingNeighbors+=1
                    }
                }
                switch livingNeighbors {
                case 3:
                    after.twoDimentionalArrayOfBools[h][w] = true
                case 2:
                   after.twoDimentionalArrayOfBools[h][w] = after.twoDimentionalArrayOfBools[h][w]
                default:
                    after.twoDimentionalArrayOfBools[h][w] = false
                }

            }
        }
        stringToBeResult += "total population after: \(after.getPopulation())"
        result.text = stringToBeResult
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Problem 2"
//        let life = LifeGameArray(height: 10, width: 10)
//        print(life.printArrarInGrid(life.twoDimentionalArrayOfBools))
//        print(life.printArray(life.WhoAreMyNeighbors(CellIndex(0,0))!))
//        life.amIAlive(CellIndex(0,0))
//        var newStatus = ""
//        if(life.amIAlive(CellIndex(0,0))){
//            newStatus = "true"
//        }
//        else{
//            newStatus = "false"
//        }
//        print("[0,0] becomes \(newStatus)")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

