//
//  CalculatorOperation.swift
//  Calculator-clone
//
//  Created by Vinayaka Prabhu on 02/10/25.
//

import Foundation

enum CalculatorOperation {
    
    case divide
    case multiply
    case add
    case subtract
    
    var title: String {
        switch self {
        case .divide:
            return "/"
        case .multiply:
            return "*"
        case .add:
            return "+"
        case .subtract:
            return "-"
        }
    }
}
