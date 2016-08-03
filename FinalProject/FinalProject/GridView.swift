//
//  GridView.swift
//  FinalProject
//
//  Created by Jack Ferrari on 8/1/16.
//  Copyright © 2016 Jack Ferrari. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable class GridView: UIView {
    
    @IBInspectable var rows: Int = 20 {
        didSet{
            grid = Array(count: rows, repeatedValue: Array(count: cols, repeatedValue: CellStates.Empty))
        }
    }
    @IBInspectable var cols: Int = 20 {
        didSet{
            grid = Array(count: rows, repeatedValue: Array(count: cols, repeatedValue: CellStates.Empty))
        }
    }
    @IBInspectable var LivingColor: UIColor = UIColor.blueColor()
    @IBInspectable var BornColor: UIColor = UIColor.cyanColor()
    @IBInspectable var EmptyColor: UIColor = UIColor.grayColor()
    @IBInspectable var DiedColor: UIColor = UIColor.greenColor()
    @IBInspectable var gridWidth: CGFloat = 2.0
    let π:CGFloat = CGFloat(M_PI)
    var points:[CellIndex] = [] {
        didSet {
            if points.count > 0 {
                self.rows = points.map{ $0.height }.reduce(0) { $0 > $1 ? $0 : $1}+2
                self.cols = points.map { $0.width }.reduce(0) { $0 > $1 ? $0 : $1}+2
                _ = points.map {
                    grid[$0.height][$0.width] = CellStates.Living
                }
            }
        }
    }
    
    func getMax(search: [Int]) -> Int {
        return search.reduce(0) { $0 > $1 ? $0 : $1}
    }
    
    var grid: Array<Array<CellStates>> = [[]]
    
    override func drawRect(rect: CGRect) {
        var xPos: CGFloat = 0
        var yPos: CGFloat = 0
        let yAdd = bounds.width/CGFloat(rows)
        let xAdd = bounds.height/CGFloat(cols)
        for h in 0..<rows{
            for w in 0..<cols{
                let tempHolder: CGRect = CGRect(x: xPos+0.5, y: yPos+0.5, width: xAdd-1, height: yAdd-1)
                let path = UIBezierPath(ovalInRect: tempHolder)
                getStatus(h, y: w).setFill()
                path.fill()
                xPos += xAdd
            }
            yPos += yAdd
            xPos = 0
        }
    }
    
    func getStatus(x: Int, y:Int) -> UIColor {
        switch grid[x][y] {
        case CellStates.Empty:
            return EmptyColor
        case CellStates.Died:
            return DiedColor
        case CellStates.Born:
            return BornColor
        case CellStates.Living:
            return LivingColor
        }
    }
    
    func toggleStatusFromLoc(xloc: CGFloat, yloc: CGFloat) -> (x: Int, y:Int) {
        let y = Int(floor( (xloc / bounds.width ) * CGFloat(cols)))
        let x = Int(floor( (yloc / bounds.height) * CGFloat(rows)))
        let pos = (x, y)
        return pos
    }
    
}