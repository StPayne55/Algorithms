//: Playground - noun: a place where people can play

import UIKit


enum BinaryTree<T: Comparable> {
    case empty
    indirect case node(BinaryTree, T, BinaryTree)

    var count: Int {
        switch self {
        case let .node(left, _, right):
            return left.count + 1 + right.count
        default:
            return 0
        }
    }

    mutating func insert(newValue: T) {
        self = newTreeWithInsertedValue(newValue: newValue)
    }

    private func newTreeWithInsertedValue(newValue: T) -> BinaryTree {
        switch self {

        case .empty:
            return .node(.empty, newValue, .empty)
        case let .node(left, value, right):
            if newValue < value {
                return .node(left.newTreeWithInsertedValue(newValue: newValue), value, right)
            } else {
                return .node(left, value, right.newTreeWithInsertedValue(newValue: newValue))
            }
        }
    }
}

extension BinaryTree: CustomStringConvertible {
    var description: String {
        switch self {
        case let .node(left, value, right):
            return "\(value) " + left.description + right.description
        case .empty:
            return "- "
        }
    }

    // MARK: - Transversal Algorithms
    func traverseInOrder(process: (T) -> ()) {
        switch self {
        case .empty: return
        case let .node(left, value, right):
            left.traverseInOrder(process: process)
            process(value)
            right.traverseInOrder(process: process)
        }
    }

    func traversePostOrder( process: (T) -> ()) {
        switch self {
        case .empty:
            return
        case let .node(left, value, right):
            left.traversePostOrder(process: process)
            right.traversePostOrder(process: process)
            process(value)
        }
    }

    func traversePreOrder( process: (T) -> ()) {
        switch self {
        case .empty:
            return
        case let .node(left, value, right):
            process(value)
            left.traversePostOrder(process: process)
            right.traversePostOrder(process: process)
        }
    }
}

// Create new binary tree
var binaryTree: BinaryTree<Int> = .empty
binaryTree.insert(newValue: 7)
binaryTree.insert(newValue: 10)
binaryTree.insert(newValue: 2)
binaryTree.insert(newValue: 1)
binaryTree.insert(newValue: 5)
binaryTree.insert(newValue: 9)


// Encodes tree to a single String
func encodeTree() -> String {
    return binaryTree.description
}

// Decodes a tree from a single String, with a specifier the denotes an empty node
func decodeTree(fromString string: String, nilNodeSpecifier: String) -> BinaryTree<Int>? {
    var newTree: BinaryTree<Int> = .empty
    let numArray = string.components(separatedBy: nilNodeSpecifier).flatMap({ Int($0) })

    for num in numArray {
        newTree.insert(newValue: num)
    }

    guard newTree.count > 0 else { return nil }

    return newTree
}


// Encode tree to string
let treeAsString = encodeTree()
print(treeAsString)

// Decode string to tree
if let newTree = decodeTree(fromString: treeAsString, nilNodeSpecifier: " ") {
    print(newTree.description)
}

