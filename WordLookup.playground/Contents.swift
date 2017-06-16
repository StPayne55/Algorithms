//: Playground - noun: a place where people can play

import UIKit

//MARK: - Store and lookup a word
let words = ["cat", "car", "cow", "dog", "bird", "worm"]

func wordFor(input: String) -> [String] {
    return words.filter({ $0.hasPrefix(input) })
}

func wordContaining(input: String) -> [String] {
    return words.filter({ $0.contains(input) })
}

print(wordFor(input: "ir"))
print(wordContaining(input: "ir"))
