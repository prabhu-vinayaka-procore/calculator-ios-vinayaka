//
//  CalculatorButton.swift
//  Calculator-clone
//
//  Created by Vinayaka Prabhu on 13/09/25.
//

import UIKit

enum CalculatorButton {
    
    case allClear
    case plusMinus
    case percent
    case divide
    case multiply
    case subtract
    case add
    case equal
    case number(Int)
    case decimal
    
    init(calcButton: CalculatorButton) {
        switch calcButton {
        case .allClear, .plusMinus, .percent, .divide, .multiply, .add, .equal, .decimal, .subtract  :
            self = calcButton
        case .number(let int):
            if int.description.count == 1 {
                self = calcButton
            }else {
                fatalError( "CalculatorButton.number int was not 1 digit during init")
            }
        }
    }
}


extension CalculatorButton {
    
    var title: String {
        switch self {
        case .allClear:
            return "AC"
        case .plusMinus:
            return "±"
        case .percent:
            return "%"
        case .divide:
            return "/"
        case .multiply:
            return "×"
        case .subtract:
            return "-"
        case .add:
            return "+"
        case .equal:
            return "="
        case .decimal:
            return "."
        case .number(let int):
            return int.description
        }
    }
    
    var color: UIColor {
        switch self {
        case .allClear, .plusMinus, .percent:
            return .lightGray
        case  .divide, .multiply, .subtract, .add, .equal:
            return .systemOrange
        case .number, .decimal:
            return .darkGray
        }
    }
    
    var selectedColor: UIColor? {
        switch self {
        case .allClear, .plusMinus, .percent, .equal, .decimal, .number:
            return nil
        case  .divide, .multiply, .subtract, .add:
            return .white
        }
    }
}
