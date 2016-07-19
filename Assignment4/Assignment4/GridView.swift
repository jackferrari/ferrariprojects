//
//  GridView.swift
//  Assignment4
//
//  Created by Jack Ferrari on 7/18/16.
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
    @IBInspectable var GridColor: UIColor = UIColor.redColor()
    @IBInspectable var gridWidth: CGFloat = 2.0
    let π:CGFloat = CGFloat(M_PI)
    
    var grid: Array<Array<CellStates>> = [[]]
    
    override func drawRect(rect: CGRect) {
        let GridPath = UIBezierPath()
        GridPath.lineWidth = gridWidth
        var xPos: Int = 0
        var yPos: Int = 0
        let yAdd: Int = Int(bounds.height) / rows
        let xAdd: Int = Int(bounds.width) / cols
        
        for _ in 0...rows {
            GridPath.moveToPoint(CGPoint(x: xPos, y: yPos))
            GridPath.addLineToPoint(CGPoint(x: Int(bounds.width), y: yPos))
            yPos += yAdd
        }
        yPos = 0
        for _ in 0...cols {
            GridPath.moveToPoint(CGPoint(x: xPos, y: yPos))
            GridPath.addLineToPoint(CGPoint(x: xPos, y: Int(bounds.height)))
            xPos += xAdd
        }
        GridColor.setStroke()
        GridPath.stroke()
        drawStatus(rect)
    }
    
    func drawStatus(rect: CGRect){
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