//
//  ViewController.swift
//  Assignment2
//
//  Created by Jack Ferrari on 7/4/16.
//  Copyright © 2016 Jack Ferrari. All rights reserved.
//

import UIKit

class Problem4ViewController: UIViewController {
    
    @IBOutlet weak var result: UITextView!
    @IBAction func clicked(sender: AnyObject) {
        let before = Engine(height: 10, width: 10)
        var stringToBeResult = ""
        stringToBeResult += "total population before: \(before.getPopulation())"
        stringToBeResult += "\n"
        let after = before.nextIderation(before)
        stringToBeResult += "total population after: \(after.getPopulation())"
        result.text = stringToBeResult
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Problem 4"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

