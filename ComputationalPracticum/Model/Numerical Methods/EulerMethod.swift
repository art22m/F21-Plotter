//
//  EulerMethod.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 12.10.2021.
//

import Foundation

class EulerMethod: INumericalMethod {    
    let grid: Grid
    let equation: IDifferentialEquation
    
    init(solve equotion: IDifferentialEquation, N: Int, X: Double) {
        self.equation = equotion
        self.grid = Grid(N: N, X: X)
    }
    
    func compute() -> [CGPoint] {
        let h = (grid.getX() - equation.x_0) / (Double(grid.getN()))
        
        grid.points.append(CGPoint(x: equation.x_0, y: equation.y_0))
        for i in 1 ... grid.getN() {
            let x_prev = grid.points[i - 1].x
            let y_prev = grid.points[i - 1].y
            
            let x = x_prev + h
            let y = h * equation.getDerivativeValue(x: x_prev, y: y_prev) + y_prev
            grid.points.append(CGPoint(x: x, y: y))
        }
        
        return grid.points
    }
    
    func computeLTE() -> [CGPoint] {
        var errorPoints = [CGPoint]()
        let graphPoints = compute()
        
        for point in graphPoints {
            let error = abs(equation.getExactValue(x: point.x) - point.y)
            errorPoints.append(CGPoint(x: point.x, y: error))
        }
        
        return errorPoints
    }
    
    func computeGTE(from N_i: Int, to N_f: Int) -> [CGPoint] {
        var errorPoints = [CGPoint]()
        
        for n in N_i ... N_f {
            let newMethod = EulerMethod(solve: equation, N: n, X: grid.getX())
            let LTEpoints = newMethod.computeLTE()

            let mx = LTEpoints.max() { $0.y < $1.y}
            errorPoints.append(CGPoint(x: CGFloat(n), y: mx?.y ?? 0.0))
        }
        
        return errorPoints
    }
}
