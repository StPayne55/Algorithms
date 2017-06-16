/*
 Task:
    Given an array of integers, return indices of the two numbers such that they add up to a specific target.

    You may assume that each input would have exactly one solution, and you may not use the same element twice.

    Example:
    Given nums = [2, 7, 11, 15], target = 9,

    Because nums[0] + nums[1] = 2 + 7 = 9,
    return [0, 1].
*/


import UIKit

/// This appears to be as optimized as possible. Runs with O(n) time complexity where n is equal to the number of integers in the set at the worst.
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
