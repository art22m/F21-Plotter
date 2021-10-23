//
//  RungeKuttaMethod.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 13.10.2021.
//

import Foundation

class RungeKuttaMethod: INumericalMethod {
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
            
            let K1 = h * equation.getDerivativeValue(x: x_prev, y: y_prev)
            let K2 = h * equation.getDerivativeValue(x: x_prev + h / 2, y: y_prev + K1 / 2)
            let K3 = h * equation.getDerivativeValue(x: x_prev + h / 2, y: y_prev + K2 / 2)
            let K4 = h * equation.getDerivativeValue(x: x_prev + h, y: y_prev + K3)
            
            let x = x_prev + h
            let y = y_prev + 1/6 * (K1 + 2 * K2 + 2 * K3 + K4)
            
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
            let newMethod = RungeKuttaMethod(solve: equation, N: n, X: grid.getX())
            let LTEpoints = newMethod.computeLTE()

            let mx = LTEpoints.max() { $0.y < $1.y}
            
            errorPoints.append(CGPoint(x: CGFloat(n), y: mx?.y ?? 0.0))
        }
    
        return errorPoints
    }
}
