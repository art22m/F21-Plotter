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
    var numberOfPoints: Int
    var xBound: Double
    
    init() {
        points = []
        numberOfPoints = 0
        xBound = 0.0
    }
    
    init(numberOfPoints: Int, xBound: Double) {
        points = [CGPoint](repeating: CGPoint(x: 0.0, y: 0.0), count: numberOfPoints)
        self.numberOfPoints = numberOfPoints
        self.xBound = xBound
    }    
}
