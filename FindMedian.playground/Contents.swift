/*
    Task: Given that integers are read from a data stream. Find median of elements read so for in efficient way.
          For simplicity assume there are no duplicates.
 
    At first glance it appears like finding the median would be expensive since we're sorting the set before we determine the median.
    Apple's built-in sort() function is using IntroSort. This is one of the fastest sorting algorithms around.
    
    IntroSort starts off with QuickSort. Once the recursion depth goes more than a certain limit,
    it'll switch to HeapSort to avoid QuickSort's worst-case O(n^2) time complexity.
    However for sets smaller than 16, it decays into InsertionSort since it performs best with small sets.
 
    There's really only one other established way to find the median without sorting. That's using the 'Median of Medians Algorithm'.
    That algorithm is very complex and would actually perform slower than IntroSort in many scenarios.
 
    That is, since we can sort a set of numbers and determine it's median more efficiently than we can find the median of an unsorted set,
    we're going to happily sort the set first.
*/


import UIKit

//MARK: - Median Finder
class MedianFinder: CustomStringConvertible {
    var numbers = [Int]()

    //description simply used for formatting output in a more friendly way and shouldn't be considered as part of the solution's overall efficiency.
    var description: String {
        var elements: String = "["
        for num in numbers {
            elements = elements.appending("\(num) ")
        }
        elements = elements.appending("]")

        return elements
    }

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

    // O(1)
    func addNum(num: Int) {
        numbers.append(num)
    }


    // O(n) where n is the size of the numbers array
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
mf.addNum(num: 1)
mf.addNum(num: 2)
mf.addNum(num: 3)
mf.addNum(num: 6)
mf.addNum(num: 8)

let meanAndMedian = mf.findMean(set: mf)
print("Mean: \(meanAndMedian.0)")
print("Median: \(meanAndMedian.1)")
