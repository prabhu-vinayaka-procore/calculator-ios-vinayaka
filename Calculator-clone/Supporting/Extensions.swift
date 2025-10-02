//
//  Extensions.swift
//  Calculator-clone
//
//  Created by Vinayaka Prabhu on 02/10/25.
//

import Foundation


extension Double {
    var toInt: Int {
        return Int(self)
    }
}


extension String {
    var toDobule: Double? {
        return Double(self)
    }
}


extension FloatingPoint {
    var isInteger: Bool { return rounded() == self }
}
