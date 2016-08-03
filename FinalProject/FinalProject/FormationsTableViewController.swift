//
//  FormationsTableViewController.swift
//  FinalProject
//
//  Created by Jack Ferrari on 8/2/16.
//  Copyright © 2016 Jack Ferrari. All rights reserved.
//

import UIKit

class FormationsTableViewController: UITableViewController {
    
    //private var formations: Array<Dictionary<String,AnyObject>> = []
    private var formNames: Array<String> = []
    private var forms: Array<Array<CellIndex>> = []

    @IBAction func addFormation(sender: AnyObject) {
        formNames.append("New Formation")
        forms.append([])
        let itemRows = forms.count - 1
        let itemPath = NSIndexPath(forRow: itemRows, inSection: 0)
        tableView.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let data = getData()
        let url = NSURL(string: "https://dl.dropboxusercontent.com/u/7544475/S65g.json")!
        data.requestJSON(url) { (json, message) in
            if let json = json,
                arr = json as? Array<Dictionary<String,AnyObject>> {
                //self.formations = arr
                _ = arr.map {
                    self.formNames.append($0["title"] as! String)
                }
                _ = arr.map {
                    var addOn: Array<CellIndex> = []
                    let temp: Array<Array<Int>> = $0["contents"] as! Array<Array<Int>>
                    for i in 0..<temp.count {
                        addOn.append(CellIndex(temp[i][0], temp[i][1]))
                    }
                    self.forms.append(addOn)
                }
                let op = NSBlockOperation {
                    self.tableView.reloadData()
                }
                NSOperationQueue.mainQueue().addOperation(op)
            }
        }
        let sel1 = #selector(FormationsTableViewController.updateTable(_:))
        let sel2 = #selector(FormationsTableViewController.addPassedRow(_:))
        NSNotificationCenter.defaultCenter().addObserver(self, selector: sel1, name: "urlPass", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: sel2, name: "datafortable", object: nil)
    }
    
    func addPassedRow (notification: NSNotification) {
        formNames.append(notification.userInfo!["name"] as! String)
        var addOn: Array<CellIndex> = []
        let temp: Array<Array<Int>> = notification.userInfo!["contents"] as! Array<Array<Int>>
        for i in 0..<temp.count {
            addOn.append(CellIndex(temp[i][0], temp[i][1]))
        }
        forms.append(addOn)
        let itemRows = forms.count - 1
        let itemPath = NSIndexPath(forRow: itemRows, inSection: 0)
        tableView.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)
    }
    
    func updateTable(notification:NSNotification) {
        let data = getData()
        let url = NSURL(string: notification.userInfo!["url"] as! String)!
        data.requestJSON(url) { (json, message) in
            if let json = json,
                arr = json as? Array<Dictionary<String,AnyObject>> {
                self.formNames = []
                self.forms = []
                _ = arr.map {
                    self.formNames.append($0["title"] as! String)
                }
                _ = arr.map {
                    var addOn: Array<CellIndex> = []
                    let temp: Array<Array<Int>> = $0["contents"] as! Array<Array<Int>>
                    for i in 0..<temp.count {
                        addOn.append(CellIndex(temp[i][0], temp[i][1]))
                    }
                    self.forms.append(addOn)
                }
                let op = NSBlockOperation {
                    self.tableView.reloadData()
                }
                NSOperationQueue.mainQueue().addOperation(op)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: flagging
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forms.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("proto")
            else {
                preconditionFailure("default isn't there")
                
        }
        let row = indexPath.row
        guard let nameLabel = cell.textLabel else {
            preconditionFailure("labeling problem")
        }
        nameLabel.text = formNames[row]
        cell.tag = row
        return cell
    }
    
    func tableView(tableView:UITableView, commitEditingStyle editingStyle:UITableViewCellEditingStyle, cellForRowAtIndexPath indexPath:NSIndexPath) {
        if editingStyle == .Delete {
            forms.removeAtIndex(indexPath.row)
            formNames.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let editingRow = (sender as! UITableViewCell).tag
        let editingString = formNames[editingRow]
        let editingArray = forms[editingRow]
        guard let edit = segue.destinationViewController as? EditingViewController
            else {
                preconditionFailure("sent to the wrong place")
        }
        edit.name = editingString
        edit.points = editingArray
        edit.commit = {
            (name:String, points:Array<CellIndex>) in
            self.formNames[editingRow] = name
            self.forms[editingRow] = points
            let indexPath = NSIndexPath(forRow: editingRow, inSection: 0)
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    


}
