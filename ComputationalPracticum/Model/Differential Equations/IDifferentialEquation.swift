//
//  IDifferentialEquation.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 12.10.2021.
//

import Foundation

protocol IDifferentialEquation {
    var x_0: Double { get set }
    var y_0: Double { get set }
    
    func getExactValue(x: Double) -> Double
    func getDerivativeValue(x: Double, y: Double) -> Double
    func getPointsOfDiscontinuity() -> [Double]
}
