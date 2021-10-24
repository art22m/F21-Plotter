//
//  Grid.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 12.10.2021.
//

import Foundation
import Charts

/*
 Grid class representing plot, i.e. contains number of points,
 bound of X axis and points to plot.
 */
class Grid {
    private var N: Int // Number of points
    private var X: Double // X bound
    var points: [CGPoint]
    
    init() {
        points = []
        N = 0
        X = 0.0
    }
    
    init(N: Int, X: Double) {
        points = []
        self.N = N
        self.X = X
    }
    
    func getN() -> Int {
        return N
    }
    
    func getX() -> Double {
        return X
    }
}
