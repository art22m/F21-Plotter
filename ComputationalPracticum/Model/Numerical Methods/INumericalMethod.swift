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
             3) Compute function which return array of struct Point.
 */

protocol INumericalMethod {
    var grid: Grid { get set }
    var equation: IDifferentialEquation { get set }
    func compute() -> [CGPoint]
}
