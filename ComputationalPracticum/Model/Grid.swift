//
//  Grid.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 12.10.2021.
//

import Foundation
import Charts

class Grid {
    var points: [CGPoint]
    var N: Int // Number of points
    var X: Double // X bound
    
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
}
