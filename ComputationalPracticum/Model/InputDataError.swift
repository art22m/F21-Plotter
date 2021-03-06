//
//  InputDataError.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 14.10.2021.
//

import Foundation

/*
 This enum representing the input data error that can be thrown
 */
enum InputDataError: Error {
    // Throw when specified interval containts points of discontinuity
    case points_of_discontinuity
    
    // Throw when x_0 greater than X
    case invalid_interval
    
    // Throw when user don't specify all the data
    case miss_data
    
    // Throw when user enter not natural N
    case invalid_N
    
    // Throw when user enter very large/small numbers
    case out_of_bounds
    
    // Throw when user enter not natural border
    case invalid_border
    
    // Throw whent user enter value of left border less than right
    case invalid_borders_inverval
    
    case invalid_h
}

/*
 This extenstion contains description for the input data errors
 */
extension InputDataError: CustomStringConvertible {
    public var description: String {
            switch self {
            case .points_of_discontinuity:
                return "Specified interval containts point(s) of discontinuity"
            case .invalid_interval:
                return "x_0 should be less than X"
            case .miss_data:
                return "Specify all the data correctly and tap plot button"
            case .invalid_N:
                return "N should be natural number >= 2"
            case .out_of_bounds:
                return "Absolute value of parameters must not exceed 10,000"
            case .invalid_borders_inverval:
                return "Value of left border should be less than right"
            case .invalid_border:
                return "Border value is natural number more than 2 and less than 2,000"
            case .invalid_h:
                return "h should be less than 1"
            }
    }
}
