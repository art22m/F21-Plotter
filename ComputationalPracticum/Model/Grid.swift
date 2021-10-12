//
//  Grid.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 12.10.2021.
//

import Foundation

class Grid {
    var points: [Point]
    var numberOfPoints: Int
    var xBound: Double
    
    init() {
        points = []
        numberOfPoints = 0
        xBound = 0.0
    }
    
    init(numberOfPoints: Int, xBound: Double) {
        points = [Point](repeating: Point(), count: numberOfPoints)
        self.numberOfPoints = numberOfPoints
        self.xBound = xBound
    }    
}
