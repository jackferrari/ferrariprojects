//
//  GridProtocol.swift
//  FinalProject
//
//  Created by Jack Ferrari on 8/1/16.
//  Copyright © 2016 Jack Ferrari. All rights reserved.
//

import UIKit

typealias CellIndex = (height: Int, width: Int)

protocol GridProtocol {
    init(row:Int, col:Int)
    var rows: Int {get}
    var cols: Int {get}
    func neighbors(loc: CellIndex) -> [CellIndex]
    subscript(row: Int, col: Int) -> CellStates {get set}
}