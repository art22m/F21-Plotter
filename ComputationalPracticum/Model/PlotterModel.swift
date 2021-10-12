//
//  PlotterModel.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 12.10.2021.
//

import Foundation
import Charts

class PlotterModel {
    var equation: IDifferentialEquation
    
    var eulerMethod: INumericalMethod
    var improvedEulerMethod: INumericalMethod
    var rungeKuttaMethod: INumericalMethod
    
    init(equation: IDifferentialEquation, N: Int, X: Double) {
        // Equation
        self.equation = equation
        
        // Methods
        self.eulerMethod = EulerMethod(solve: self.equation, N: N, X: X)
        self.improvedEulerMethod = ImprovedEulerMethod(solve: self.equation, N: N, X: X)
        self.rungeKuttaMethod = RungeKuttaMethod(solve: self.equation, N: N, X: X)
    }
    
    func getPointsEuler() -> [ChartDataEntry] {
        return compute(using: eulerMethod)
    }
    
    func getPointsImprovedEuler() -> [ChartDataEntry] {
        return compute(using: improvedEulerMethod)
    }
    
    func getPointsRungeKutta() -> [ChartDataEntry] {
        return compute(using: rungeKuttaMethod)
    }
    
    func compute(using method: INumericalMethod) -> [ChartDataEntry] {
        let points = method.compute()
        var result = [ChartDataEntry](repeating: ChartDataEntry(), count: method.grid.numberOfPoints)
        
        for i in 0 ..< method.grid.numberOfPoints {
            result[i] = ChartDataEntry(x: points[i].x, y: points[i].y)
        }
        
        return result
    }
}
