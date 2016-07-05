//
//  LifeGameArray.swift
//  Assignment2
//
//  Created by Jack Ferrari on 7/4/16.
//  Copyright © 2016 Jack Ferrari. All rights reserved.
//

import UIKit
import Foundation


typealias CellIndex = (height: Int, width: Int)
typealias LifeArray = Array<Array<Bool>>

class Engine {
    
    var twoDimentionalArrayOfBools: LifeArray
    let height: Int
    let width: Int
    
    init (height: Int, width: Int)
    {
        self.height = height
        self.width = width
        
        var temp = Array(count: height, repeatedValue: Array(count: width, repeatedValue: false))
        
        for h in 0..<height
        {
            for w in 0..<width {
                if arc4random_uniform(3) == 1{
                    temp[h][w] = true
                }
            }
        }
        self.twoDimentionalArrayOfBools = temp
    }
    
    func  WhoAreMyNeighbors(target: CellIndex) -> [CellIndex]? {
        //checks if valid index
        if (target.height < 0 || target.height >= self.height){
            return nil
        }
        //gets all coordinates and checks for wraping
        var incY = target.height+1
        var incX = target.width+1
        var decY = target.height-1
        var decX = target.width-1
        
        if incY == self.height{
            incY = 0
        }
        if incX == self.width {
            incX = 0
        }
        if decY < 0 {
            decY = self.height - 1
        }
        if decX < 0 {
            decX = self.width - 1
        }
        
        //builder of cells
        func returnCellIndex(y:Int, x:Int) -> CellIndex {
            var cell:CellIndex
            cell.height = y
            cell.width = x
            return cell
        }
        
        //final array of neighbor cells
        let Neighbors: Array<CellIndex> = [returnCellIndex(decY, x:decX), returnCellIndex(decY, x:target.width), returnCellIndex(decY, x:incX), returnCellIndex(target.height, x:decX), returnCellIndex(target.height, x:incX), returnCellIndex(incY, x:decX), returnCellIndex(incY, x:target.width), returnCellIndex(incY, x:incX)]
        return Neighbors
    }
    
    func amIAlive(position: CellIndex) -> Bool{
        var livingNeighbors = 0
        let status = twoDimentionalArrayOfBools[position.height][position.width]
        let neighbors = WhoAreMyNeighbors(position)
        for w in 0..<neighbors!.count{
            let width = neighbors![w].width
            let height = neighbors![w].height
            if self.twoDimentionalArrayOfBools[height][width] == true{
                livingNeighbors+=1
            }
        }
        var newStatus: Bool
        switch livingNeighbors {
        case 3:
            newStatus = true
        case 2:
            if (status){
                newStatus = true
            }
            else{
                newStatus = false
            }
        default:
            newStatus = false
        }
        return newStatus
    }
    
    func getPopulation() -> Int{
        var population: Int = 0
        for h in 0..<self.height{
            for w in 0..<self.width{
                if twoDimentionalArrayOfBools[h][w]{
                    population+=1
                }
            }
        }
        return population
    }
    
    func nextIderation(orignial: Engine) -> Engine{
        for h in 0..<orignial.height{
            for w in 0..<orignial.width{
                let newStatus = amIAlive(CellIndex(h, w))
                orignial.twoDimentionalArrayOfBools[h][w] = newStatus
            }
        }
        return orignial
    }
    
    func Step(orignial: Engine) -> Engine{
        for h in 0..<orignial.height{
            for w in 0..<orignial.width{
                //gets all coordinates and checks for wraping
                var incY = h+1
                var incX = w+1
                var decY = h-1
                var decX = w-1
                
                if incY == orignial.height{
                    incY = 0
                }
                if incX == orignial.width {
                    incX = 0
                }
                if decY < 0 {
                    decY = orignial.height - 1
                }
                if decX < 0 {
                    decX = orignial.width - 1
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
                    if orignial.twoDimentionalArrayOfBools[height][width] == true{
                        livingNeighbors+=1
                    }
                }
                switch livingNeighbors {
                case 3:
                    orignial.twoDimentionalArrayOfBools[h][w] = true
                case 2:
                    orignial.twoDimentionalArrayOfBools[h][w] = orignial.twoDimentionalArrayOfBools[h][w]
                default:
                    orignial.twoDimentionalArrayOfBools[h][w] = false
                }

            }
        }
        return orignial
    }
}
