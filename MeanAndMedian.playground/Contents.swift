//: Playground - noun: a place where people can play

import UIKit

class MedianFinder {
    var numbers = [Int]()

    // O(n log n) for sort, O(1) for median
    func findMedian() -> Double {
        guard numbers.count != 0 else { fatalError("Set must have elements") }
        numbers.sort()

        if numbers.count % 2 != 0 {
            let split = Int(numbers.count / 2)

            return Double(numbers[split])
        }

        let right = Double(numbers[Int(numbers.count / 2)])
        let left = Double(numbers[Int(numbers.count / 2) - 1])
        return Double((right + left) / 2.0)
    }

    // O(n)
    func addNum(num: Int) {
        numbers.append(num)
    }


    // O(n)
    func findMean(set: MedianFinder) -> (Double, Double) {
        let median = set.findMedian()
        var mean = 0.0
        for num in set.numbers {
            mean += Double(num)
        }

        mean = mean / Double(set.numbers.count)
        return (mean, median)
    }
}

let mf = MedianFinder()
mf.addNum(num: 3)
mf.addNum(num: 4)
mf.addNum(num: 2)
mf.addNum(num: 9)

let meanAndMedian = mf.findMean(set: mf)
print("Mean: \(meanAndMedian.0)\nMedian: \(meanAndMedian.1)")

let time = PerformanceMeasurer.timeElapsedForFunction(title: "Finding Mean", operation: {
    mf.findMean(set: mf)
})

print(time)
