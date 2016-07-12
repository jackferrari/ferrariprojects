//
//  CellStates.swift
//  Assignment3
//
//  Created by Jack Ferrari on 7/11/16.
//  Copyright © 2016 Jack Ferrari. All rights reserved.
//

import UIKit

enum CellStates: String {
    
    case Living
    case Empty
    case Born
    case Died
    
    var status: String {
        switch (self) {
        case .Living:
            return "Living"
        case .Empty:
            return "Empty"
        case .Born:
            return "Born"
        case .Died:
            return "Died"
        }
    }
    
    func allValues() -> Array<String> {
        let val = ["Living", "Empty", "Born", "Died"]
        return val
    }
    
    static func toggle(value:CellStates)-> CellStates{
        switch value {
        case .Living:
            return .Empty
        case .Born:
            return .Empty
        case .Empty:
            return .Living
        case .Died:
            return .Living
        }
    }
    
    
}
