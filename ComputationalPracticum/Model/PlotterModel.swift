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
    
    /*
     Compute the points and cast them to ChartDataEntry,
     ChartDataEntry class used to plot the graphs.
     */
    func compute(using method: INumericalMethod) -> [ChartDataEntry] {
        let points = method.compute()
        var result = [ChartDataEntry](repeating: ChartDataEntry(), count: method.grid.numberOfPoints)
        
        for i in 0 ..< method.grid.numberOfPoints {
            result[i] = ChartDataEntry(x: points[i].x, y: points[i].y)
        }
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
        
        for x in equation.getPointsOfDiscontinuity() {
            if (Double(x_0)! <= x && x <= Double(X)!) {
                throw InputDataError.points_of_discontinuity
            }
        }
        
        // Equation
        self.equation.x_0 = Double(x_0)!
        self.equation.y_0 = Double(y_0)!

        // Methods
        self.eulerMethod = EulerMethod(solve: self.equation, N: Int(N)!, X: Double(X)!)
        self.improvedEulerMethod = ImprovedEulerMethod(solve: self.equation, N: Int(N)!, X: Double(X)!)
        self.rungeKuttaMethod = RungeKuttaMethod(solve: self.equation, N: Int(N)!, X: Double(X)!)
    }
}
