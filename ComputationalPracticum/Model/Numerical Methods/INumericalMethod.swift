//
//  NumericalMethod.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 12.10.2021.
//

import Foundation

/*
 INumericalMethod - interface for numerical method;
 It contains 1) Grid which we need for plottings graphs
             2) Equotion we want to solve
             3) Compute method returning array of points
             calculated using numerical method
             4) Compute local truncation error method
             5) Compute global truncation error method
 */

protocol INumericalMethod {
    var grid: Grid { get }
    var equation: IDifferentialEquation { get }
    
    func compute() -> [CGPoint]
    func computeLTE() -> [CGPoint]
    func computeGTE(from N_i: Int, to N_f: Int) -> [CGPoint]
}
