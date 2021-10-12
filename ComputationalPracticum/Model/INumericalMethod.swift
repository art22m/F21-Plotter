//
//  NumericalMethod.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 12.10.2021.
//

import Foundation

protocol INumericalMethod {
    var grid: Grid { get set }
    var equotion: IDifferentialEquation { get set }
    func compute() -> [Point] // get array of computed points
}
