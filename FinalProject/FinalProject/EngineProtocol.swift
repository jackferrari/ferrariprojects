//
//  EngineProtocol.swift
//  FinalProject
//
//  Created by Jack Ferrari on 8/1/16.
//  Copyright © 2016 Jack Ferrari. All rights reserved.
//

import Foundation

protocol EngineProtocol {
    var delegate: EngineDelegate? {get set}
    var grid: GridProtocol {get}
    var refreshRate: Double {get set}
    var refreshTimer: NSTimer! {get set}
    var rows: Int {get set}
    var cols: Int {get set}
    init (rows: Int, cols: Int)
    func step() -> GridProtocol
}
