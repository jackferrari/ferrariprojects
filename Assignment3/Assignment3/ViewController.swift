//
//  ViewController.swift
//  Assignment3
//
//  Created by Jack Ferrari on 7/11/16.
//  Copyright © 2016 Jack Ferrari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Grid: GridView!
    @IBAction func changeStatus(sender: AnyObject) {
        let loc = sender.locationInView(Grid!)
        Grid.toggleStatusFromLoc(loc.x, yloc: loc.y)
        Grid.setNeedsDisplay()
        
    }
    
    @IBAction func Run(sender: AnyObject) {
        let GM = GameManager()
        Grid.grid = GM.step(Grid.grid, rows: Grid.rows, cols: Grid.cols)
        Grid.setNeedsDisplay()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

