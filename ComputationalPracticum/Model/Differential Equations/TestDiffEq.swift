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
    
    func getDerivativeValue(x: Double, y: Double) -> Double {
        let value = -y + sin(x)
        
        return value
    }
    
    func getPointsOfDiscontinuity() -> [Double] {
        return []
    }
}
