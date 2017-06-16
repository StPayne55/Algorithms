//: Playground - noun: a place where people can play

import UIKit

/// This appears to be as optimized as possible. Runs faster than 95% of solutions.
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dict: [Int: Int] = [:]

    for i in 0 ..< nums.count {
        let value = nums[i]
        if let complement = dict[target - value] {
            return [complement, i]
        }

        dict[value] = i
    }

    return []
}

let target = 10
let numbers = [0,1,4,5,3,2,9,12]
let solution = twoSum(numbers, target)
print(solution)