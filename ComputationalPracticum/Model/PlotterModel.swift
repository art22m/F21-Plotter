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
    
    /*
     Exact
     */
    
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
    
    /*
     Euler methods
     */
    
    func getPointsEuler() -> [ChartDataEntry] {
        guard let equation = equation, let grid = grid else { return [] }
        
        return computeGraphPoints(using: EulerMethod(solve: equation, N: grid.N, X: grid.X))
    }
    
    func getLocalErrorsEuler() -> [ChartDataEntry] {
        guard let equation = equation, let grid = grid else { return [] }
        
        return computeLocalErrorsPoints(using: EulerMethod(solve: equation, N: grid.N, X: grid.X))
    }
    
    func getGlobalErrorsEuler(from Ni: Int, to Nf: Int) -> [ChartDataEntry] {
        guard let equation = equation, let grid = grid else { return [] }
        
        return computeGlobalErrorsPoints(using: EulerMethod(solve: equation, N: grid.N, X: grid.X), N_i: Ni, N_f: Nf)
    }
    
    /*
     Improved Euler methods
     */
    
    func getPointsImprovedEuler() -> [ChartDataEntry] {
        guard let equation = equation, let grid = grid else { return [] }
        
        return computeGraphPoints(using: ImprovedEulerMethod(solve: equation, N: grid.N, X: grid.X))
    }
    
    func getLocalErrorsImproverEuler() -> [ChartDataEntry] {
        guard let equation = equation, let grid = grid else { return [] }
        
        return computeLocalErrorsPoints(using: ImprovedEulerMethod(solve: equation, N: grid.N, X: grid.X))
    }
    
    func getGlobalErrorsImprovedEuler(from Ni: Int, to Nf: Int) -> [ChartDataEntry] {
        guard let equation = equation, let grid = grid else { return [] }
        
        return computeGlobalErrorsPoints(using: ImprovedEulerMethod(solve: equation, N: grid.N, X: grid.X), N_i: Ni, N_f: Nf)
    }
    
    /*
     Runge-Kutta methods
     */
    
    func getPointsRungeKutta() -> [ChartDataEntry] {
        guard let equation = equation, let grid = grid else { return [] }
        
        return computeGraphPoints(using: RungeKuttaMethod(solve: equation, N: grid.N, X: grid.X))
    }
    
    func getLocalErrorsRungeKutta() -> [ChartDataEntry] {
        guard let equation = equation, let grid = grid else { return [] }
        
        return computeLocalErrorsPoints(using: RungeKuttaMethod(solve: equation, N: grid.N, X: grid.X))
    }
    
    func getGlobalErrorsRungeKutta(from Ni: Int, to Nf: Int) -> [ChartDataEntry] {
        guard let equation = equation, let grid = grid else { return [] }
        
        return computeGlobalErrorsPoints(using: RungeKuttaMethod(solve: equation, N: grid.N, X: grid.X), N_i: Ni, N_f: Nf)
    }
    
    /*
     Compute the points and cast them to ChartDataEntry,
     ChartDataEntry class used to plot the graphs.
     */
    private func computeGraphPoints(using method: INumericalMethod) -> [ChartDataEntry] {
        let points = method.compute()
        let result = points.map{ChartDataEntry(x: $0.x, y: $0.y)}
                   
        return result
    }
    
    private func computeLocalErrorsPoints(using method: INumericalMethod) -> [ChartDataEntry] {
        let points = method.computeLTE()
        let result = points.map{ChartDataEntry(x: $0.x, y: $0.y)}
        
        return result
    }
    
    private func computeGlobalErrorsPoints(using method: INumericalMethod, N_i: Int, N_f: Int) -> [ChartDataEntry] {
        let points = method.computeGTE(from: N_i, to: N_f)
        
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
        
        guard abs(Double(x_0)!) <= 10000 &&
              abs(Double(y_0)!) <= 10000 &&
              abs(Int(N)!)      <= 10000 &&
              abs(Double(X)!)   <= 10000
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
        
        // Parameters changing after error handlings
        
        equation?.x_0 = Double(x_0)!
        equation?.y_0 = Double(y_0)!
        grid = Grid(N: Int(N)!, X: Double(X)!)
    }
    
    func checkInputBorders(left: String, right: String) throws {
        guard Int(left) != nil &&
              Int(right) != nil
        else {
            throw InputDataError.invalid_border
        }
        
        guard Int(left)! >= 2 &&
              Int(right)! >= 2 
        else {
            throw InputDataError.invalid_border
        }
        
        guard Int(left)! < Int(right)! else {
            throw InputDataError.invalid_borders_inverval
        }
    }
}
