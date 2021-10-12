//
//  EulerMethod.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 12.10.2021.
//

import Foundation

class EulerMethod: INumericalMethod {
    var grid: Grid
    var equotion: IDifferentialEquation
    
    init(solve equotion: IDifferentialEquation, N: Int, X: Double) {
        self.equotion = equotion
        self.grid = Grid(numberOfPoints: N, xBound: X)
    }
    
    func compute() -> [Point] {
        let h = (grid.xBound - equotion.x_0) / (Double(grid.numberOfPoints) - 1)
        
        grid.points[0].x = equotion.x_0
        for i in 1 ..< grid.numberOfPoints {
            grid.points[i].x = grid.points[i - 1].x + (grid.xBound / Double(grid.numberOfPoints))
        }
        
        grid.points[0].y = equotion.y_0
        for i in 1 ..< grid.numberOfPoints {
            grid.points[0].y = h * equotion.getDerivativeValue(x: grid.points[i-1].x, y: grid.points[i-1].y) + grid.points[i-1].y
        }
        
        return grid.points
    }
}
