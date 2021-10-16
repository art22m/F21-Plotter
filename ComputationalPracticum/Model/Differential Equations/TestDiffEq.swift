//
//  TestDiffEq.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 12.10.2021.
//

import Foundation

class TestDiffEq: IDifferentialEquation {
    var x_0: Double
    var y_0: Double
    
    init(x_0: Double, y_0: Double) {
        self.x_0 = x_0
        self.y_0 = y_0
    }
    
    // y' = f(x,y) = 2x
    // y(x_0) = y_0
    // y = x^2 + C => C = y - x^2
    func getDerivativeValue(x: Double, y: Double) -> Double {
        let value = 5 - x * x - y * y + 2 *  x * y
        
        return value
    }
    
    func getFunctionValue(x: Double) -> Double {
        let C  = -0.75
        let e = 2.718
        let value = 1 / ( C * pow(e, 4 * x) - 0.25) + x + 2
        
        return value
    }
    
    func getPointsOfDiscontinuity() -> [Double] {
        return []
    }
}
