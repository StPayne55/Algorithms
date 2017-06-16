/*
 Task: 
    There are two sorted arrays nums1 and nums2 of size m and n respectively.
    Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).

    Example:
    nums1 = [1, 3]
    nums2 = [2]
        The median is 2.0

    Example 2:
    nums1 = [1, 2]
    nums2 = [3, 4]
        The median is (2 + 3)/2 = 2.5
 
*/

import UIKit

class Solution {

    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {

        let count = Double(nums1.count) + Double(nums2.count)
        let isOdd = count.truncatingRemainder(dividingBy: 2) == 0 ? false : true
        let midIndex = Int(floor(count / 2 + 1))

        var index = 0
        var i = 0
        var j = 0
        var p = 0
        var result: Double = 0
        var temp = 0

        while index <= midIndex {
            if index == midIndex {
                if isOdd {
                    result = Double(temp)
                } else {
                    result = (Double(temp) + Double(p)) / 2
                }
                break
            }

            if i == nums1.count {
                j = j + midIndex - index - 1
                if j == 0 {
                    p = temp
                    temp = nums2[j]
                } else {
                    p = max(temp, nums2[j - 1])
                    temp = nums2[j]
                }
                index = midIndex
            } else if j == nums2.count {
                i = i + midIndex - index - 1
                if i == 0 {
                    p = temp
                    temp = nums1[i]
                } else {
                    p = max(temp, nums1[i - 1])
                    temp = nums1[i]
                }
                index = midIndex
            } else {
                p = temp
                if nums1[i] <= nums2[j] {
                    temp = nums1[i]
                    i += 1
                } else {
                    temp = nums2[j]
                    j += 1
                }
                index = index + 1
            }
        }

        return result
    }
}

let nums1 = [1, 3]
let nums2 = [2]

let s = Solution()
print(s.findMedianSortedArrays(nums1, nums2))
