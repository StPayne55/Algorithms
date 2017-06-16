// Created by Stephen Payne
// June 14, 2017

import Foundation

class PerformanceMeasurer {
    static func timeElapsedForFunction(title: String, operation: () -> ()) {
        let startTime = CFAbsoluteTimeGetCurrent
        operation()
        let timeElapsed = CFAbsoluteTimeGetCurrent - startTime
        print("Time elapsed for \(title): \(timeElapsed) sec.")
    }

    static func timeElapsedInSecondsForFunction(operation: () -> ()) -> Double {
        let startTime = CFAbsoluteTimeGetCurrent
        operation()
        let timeElapsed = CFAbsoluteTimeGetCurrent - startTime
        return Double(timeElapsed)
    }
}
