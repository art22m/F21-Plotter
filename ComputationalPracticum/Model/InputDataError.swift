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
    case out_of_boudns
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
                return "Specify all the data correctly"
            case .invalid_N:
                return "N should be natural number >= 2"
            case .out_of_boudns:
                return "Absolute value of numbers must not exceed 100,000"
            }
    }
}
