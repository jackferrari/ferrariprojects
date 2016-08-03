//
//  StatisticsViewController.swift
//  FinalProject
//
//  Created by Jack Ferrari on 8/1/16.
//  Copyright © 2016 Jack Ferrari. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    var engine = StandardEngine.standardSingleton
    
    @IBOutlet weak var emptyText: UITextField!
    @IBOutlet weak var diedText: UITextField!
    @IBOutlet weak var bornText: UITextField!
    @IBOutlet weak var livingText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let sel = #selector(StatisticsViewController.updateStats(_:))
        NSNotificationCenter.defaultCenter().addObserver(self, selector: sel, name: notificationKey, object: nil)
        emptyText.text = "\(engine.cols * engine.rows)"
        diedText.text = "0"
        bornText.text = "0"
        livingText.text = "0"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getStat(notification:NSNotification, key:String) -> Int {
        if let num = notification.userInfo![key] as? NSNumber {
            return Int(num)
        }
        return 0
    }
    
    func updateStats(notification:NSNotification) {
        emptyText.text = "\(getStat(notification, key: "empty"))"
        diedText.text =  "\(getStat(notification, key: "died"))"
        bornText.text = "\(getStat(notification, key: "born"))"
        livingText.text = "\(getStat(notification, key: "living"))"
    }
}
