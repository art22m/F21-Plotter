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
    // y = x^2
    func getDerivativeValue(x: Double, y: Double) -> Double {
        let value = 2*x
        
        return value
    }
    
    func getPointsOfDiscontinuity() -> [Double] {
        return []
    }
}
