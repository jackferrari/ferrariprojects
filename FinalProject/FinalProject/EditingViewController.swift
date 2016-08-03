//
//  EditingViewController.swift
//  FinalProject
//
//  Created by Jack Ferrari on 8/2/16.
//  Copyright © 2016 Jack Ferrari. All rights reserved.
//

import UIKit

class EditingViewController: UIViewController {

    var name:String?
    var points:Array<CellIndex>?
    var commit: ((String, Array<CellIndex>) -> Void)?
    let engine: StandardEngine = StandardEngine.standardSingleton
    
    @IBOutlet weak var grid: GridView!
    @IBOutlet weak var nameTextFeild: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        nameTextFeild.text = name
        grid.points = points!
    }
    @IBAction func saveCurrentForm(sender: AnyObject) {
        engine.rows = grid.rows
        engine.cols = grid.cols
        guard let points = points
            else {return}
        _ = points.map {
            engine.grid[$0.height, $0.width] = CellStates.Living
        }
        engine.delegate?.engineDidUpdate(engine.grid)
    }
    
    @IBAction func toggle(sender: AnyObject) {
        let loc = sender.locationInView(grid!)
        let x: Int = grid.toggleStatusFromLoc(loc.x, yloc: loc.y).x
        let y :Int = grid.toggleStatusFromLoc(loc.x, yloc: loc.y).y
        grid.grid[x][y] = CellStates.toggle(grid.grid[x][y])
        if grid.grid[x][y] == CellStates.Living {
            points?.append(CellIndex(x, y))
        }
        grid.setNeedsDisplay()
    }
    @IBAction func save(sender: AnyObject) {
        guard let newText = nameTextFeild.text, let points = points, commit = commit
            else { return }
        commit(newText, points)
        navigationController!.popViewControllerAnimated(true)
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
