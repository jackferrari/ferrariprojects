//
//  FirstViewController.swift
//  Assignment4
//
//  Created by Jack Ferrari on 7/17/16.
//  Copyright © 2016 Jack Ferrari. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController {
    let engine: StandardEngine = StandardEngine.standardSingleton

    @IBOutlet weak var hzCount: UITextView!
    @IBOutlet weak var rows: UITextField!
    @IBOutlet weak var cols: UITextField!
    var currentRefreshRate: Double = 5.0
    
    @IBOutlet weak var onOff: UISwitch!
    
    @IBAction func toggleOnOff(sender: UISwitch) {
        if sender.on {
            engine.refreshRate = currentRefreshRate
        } else {
            engine.refreshRate = 0.0
        }
    }
    
    @IBAction func setRefresh(sender: UISlider) {
        if onOff.on {
            engine.refreshRate = Double(sender.value)
        }
        currentRefreshRate = Double(sender.value)
        hzCount.text = "\(Int(sender.value)) hz"
    }
    @IBAction func colStepper(sender: UIStepper) {
        engine.cols = Int(sender.value)
        cols.text = "\(engine.cols)"
    }
    
    @IBAction func rowStepper(sender: UIStepper) {
        engine.rows = Int(sender.value)
        rows.text = "\(engine.rows)"

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cols.text = "\(engine.cols)"
        rows.text = "\(engine.rows)"
        engine.refreshRate = currentRefreshRate
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

