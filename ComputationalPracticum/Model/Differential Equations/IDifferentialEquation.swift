//
//  IDifferentialEquation.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 12.10.2021.
//

import Foundation

/*
 IDifferentialEquation - interface for differential equation;
 It contains 1) Initial values x_0 and y_0
             2) getExactValue method returns the value of
             analytical solution function
             4) getDerivativeValue method returns the value of function
             y' = f(x, y)
             5) getPointsOfDiscontinuity method returs array of points of
             discontinuity
 */
protocol IDifferentialEquation {
    var x_0: Double { get set}
    var y_0: Double { get set }
    
    func getExactValue(x: Double) -> Double
    func getDerivativeValue(x: Double, y: Double) -> Double
    func getPointsOfDiscontinuity() -> [Double]
}

