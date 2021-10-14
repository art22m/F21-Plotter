//
//  EulerMethod.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 12.10.2021.
//

import Foundation

class EulerMethod: INumericalMethod {
    var grid: Grid
    var equation: IDifferentialEquation
    
    init(solve equotion: IDifferentialEquation, N: Int, X: Double) {
        self.equation = equotion
        self.grid = Grid(numberOfPoints: N, xBound: X)
    }
    
    func compute() -> [CGPoint] {
        let h = (grid.xBound - equation.x_0) / (Double(grid.numberOfPoints) - 1)
        
        grid.points[0].x = equation.x_0
        grid.points[grid.numberOfPoints - 1].x = Double(grid.xBound)
        for i in 1 ..< grid.numberOfPoints - 1 {
            grid.points[i].x = grid.points[i - 1].x + h
        }
        
        grid.points[0].y = equation.y_0
        for i in 1 ..< grid.numberOfPoints {
            grid.points[i].y = h * equation.getDerivativeValue(x: grid.points[i-1].x, y: grid.points[i-1].y) + grid.points[i-1].y
        }
        
        return grid.points
    }
}