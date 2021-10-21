//
//  DifferentialEquationVar1.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 17.10.2021.
//

import Foundation

/*
 Class for differential equation of Variant 1
 y' = 1 + 2y/x
 y(x) = Cx^2 - x <- general solution
 y(x_0) = C(x_0)^2 - x_0 = y_0 =>
 */

class DifferentialEquationVar1 : IDifferentialEquation {
    var x_0: Double
    var y_0: Double
    
    init(x_0: Double, y_0: Double) {
        self.x_0 = x_0
        self.y_0 = y_0
    }
    
    func getFunctionValue(x: Double) -> Double {
        let C = (y_0 + x_0) / (x_0 * x_0)
        let value = C * x * x + x
        
        return value
    }
    
    func getDerivativeValue(x: Double, y: Double) -> Double {
        let value = 1 + 2 * y / x
        
        return value
    }
    
    func getPointsOfDiscontinuity() -> [Double] {
        return [0]
    }
    
    
}
