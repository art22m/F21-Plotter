//
//  RungeKuttaMethod.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 13.10.2021.
//

import Foundation

class RungeKuttaMethod: INumericalMethod {
    var grid: Grid
    var equation: IDifferentialEquation
    
    init(solve equotion: IDifferentialEquation, N: Int, X: Double) {
        self.equation = equotion
        self.grid = Grid(numberOfPoints: N, xBound: X)
    }
    
    func compute() -> [CGPoint] {
        let h = (grid.xBound - equation.x_0) / (Double(grid.numberOfPoints))
        
        grid.points[0].x = equation.x_0
        grid.points[grid.numberOfPoints - 1].x = Double(grid.xBound)
        for i in 1 ..< grid.numberOfPoints - 1 {
            grid.points[i].x = grid.points[i - 1].x + (grid.xBound / Double(grid.numberOfPoints))
        }
        
        grid.points[0].y = equation.y_0
        for i in 1 ..< grid.numberOfPoints {
            let K1 = h * equation.getDerivativeValue(x: grid.points[i - 1].x, y: grid.points[i - 1].y)
            let K2 = h * equation.getDerivativeValue(x: grid.points[i - 1].x + h / 2, y: grid.points[i - 1].y + K1 / 2)
            let K3 = h * equation.getDerivativeValue(x: grid.points[i - 1].x + h / 2, y: grid.points[i - 1].y + K2 / 2)
            let K4 = h * equation.getDerivativeValue(x: grid.points[i - 1].x + h, y: grid.points[i - 1].y + K3)
            
            grid.points[i].y = grid.points[i - 1].y + 1/6 * (K1 + 2 * K2 + 2 * K3 + K4)
        }

        return grid.points
    }
    
    
}
