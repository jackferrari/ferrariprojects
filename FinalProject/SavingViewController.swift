//
//  SavingViewController.swift
//  FinalProject
//
//  Created by Jack Ferrari on 8/3/16.
//  Copyright © 2016 Jack Ferrari. All rights reserved.
//

import UIKit

class SavingViewController: UIViewController {
    
    @IBOutlet var saveGrid: GridView!
    @IBOutlet weak var name: UITextField!
    var points: Array<Array<Int>> = []
    let engine = StandardEngine.standardSingleton
    
    @IBAction func saveToTable(sender: AnyObject) {
        for h in 0..<saveGrid.rows {
            for w in 0..<saveGrid.cols {
                if saveGrid.grid[h][w] == CellStates.Living {
                    points.append([h, w])
                }
            }
        }
        NSNotificationCenter.defaultCenter().postNotificationName("datafortable", object: nil, userInfo: ["contents" : points,
            "name"   : name.text!])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = "New Save"
        saveGrid.grid = fillSave()
        // Do any additional setup after loading the view.
    }
    
    func fillSave() -> [[CellStates]]{
        saveGrid.rows = engine.rows
        saveGrid.cols = engine.cols
        var temp = saveGrid.grid
        for h in 0..<saveGrid.rows {
            for w in 0..<saveGrid.cols {
                temp[h][w] = engine.grid[h, w]
            }
        }
        return temp
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
