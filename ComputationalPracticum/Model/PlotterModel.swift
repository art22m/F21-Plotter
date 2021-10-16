//
//  PlotterModel.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 12.10.2021.
//

import Foundation
import Charts

class PlotterModel {
    var equation: IDifferentialEquation?
    var grid: Grid?
    
    init(equation: IDifferentialEquation) {
        // Equation
        self.equation = equation
    }
    
    init(equation: IDifferentialEquation, N: Int, X: Double) {
        // Equation
        self.equation = equation
        
        // Grid
        self.grid = Grid(N: N, X: X)
    }
    
    func getPointsExact() -> [ChartDataEntry] {
        guard let equation = equation, let grid = grid else { return [] }
        
        let h = (grid.X - equation.x_0) / Double(grid.N)
        var points = [ChartDataEntry]()
        
        points.append(ChartDataEntry(x: equation.x_0, y: equation.y_0))
        for i in 1 ... grid.N {
            let x = points[i - 1].x + h
            let y = equation.getFunctionValue(x: x)
            
            points.append(ChartDataEntry(x: x, y: y))
        }
        
        return points
    }
    
    func getPointsEuler() -> [ChartDataEntry] {
        guard let equation = equation, let grid = grid else { return [] }
        
        return compute(using: EulerMethod(solve: equation, N: grid.N, X: grid.X))
    }
    
    func getPointsImprovedEuler() -> [ChartDataEntry] {
        guard let equation = equation, let grid = grid else { return [] }
        
        return compute(using: ImprovedEulerMethod(solve: equation, N: grid.N, X: grid.X))
    }
    
    func getPointsRungeKutta() -> [ChartDataEntry] {
        guard let equation = equation, let grid = grid else { return [] }
        
        return compute(using: RungeKuttaMethod(solve: equation, N: grid.N, X: grid.X))
    }
    
    /*
     Compute the points and cast them to ChartDataEntry,
     ChartDataEntry class used to plot the graphs.
     */
    func compute(using method: INumericalMethod) -> [ChartDataEntry] {
        let points = method.compute()
        let result = points.map{ChartDataEntry(x: $0.x, y: $0.y)}
                   
        return result
    }
    
    /*
     Check for the input data erors and throw them if occurs,
     change all the parameters of the grid and equation.
     */
    func setNewParameters(x_0: String, y_0: String, N: String, X: String) throws {
        // Errors handling
        guard Double(x_0) != nil &&
              Double(y_0) != nil &&
              Int(N)      != nil &&
              Double(X)   != nil
        else {
            throw InputDataError.miss_data
        }
        
        guard abs(Double(x_0)!) <= 100000 &&
              abs(Double(y_0)!) <= 100000 &&
              abs(Int(N)!)      <= 100000 &&
              abs(Double(X)!)   <= 100000
        else {
            throw InputDataError.out_of_boudns
        }
        
        guard Int(N)! >= 2 else {
            throw InputDataError.invalid_N
        }
        
        guard Double(x_0)! < Double(X)! else {
            throw InputDataError.invalid_interval
        }
        
        if let equation = equation {
            for x in equation.getPointsOfDiscontinuity() {
                if (Double(x_0)! <= x && x <= Double(X)!) {
                    throw InputDataError.points_of_discontinuity
                }
            }
        }
        
        // Changing parameters

        equation?.x_0 = Double(x_0)!
        equation?.y_0 = Double(y_0)!
        grid = Grid(N: Int(N)!, X: Double(X)!)
    }
}
