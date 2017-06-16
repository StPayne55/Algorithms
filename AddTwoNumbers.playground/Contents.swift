//: Playground - noun: a place where people can play

import UIKit

class Node<T> {
    var value: T
    var next: Node<T>?
    weak var previous: Node<T>?


    init(value: T) {
        self.value = value
    }
}

class LinkedList<T>: CustomStringConvertible {
    var head: Node<T>?
    private var tail: Node<T>?

    public var description: String {
        var text = "["
        var node = head

        while node != nil {
            text += "\(node!.value)"
            node = node!.next
            if node != nil { text += " -> " }
        }

        return text + "]"
    }


    public var isEmpty: Bool {
        return head == nil
    }

    public var first: Node<T>? {
        return head
    }

    public var last: Node<T>? {
        return tail
    }

    public func nodeAt(index: Int) -> Node<T>? {
        if index >= 0 {
            var node = head
            var i = index

            while node != nil {
                if i == 0 { return node }
                i -= 1
                node = node!.next
            }
        }

        return nil
    }

    public func append(value: T) {
        let newNode = Node(value: value)

        if let tailNode = tail {
            newNode.previous = tailNode
            tailNode.next = newNode
        } else {
            head = newNode
        }

        tail = newNode
    }

    public func appendValues(values: [T]) {
        for value in values {
            append(value: value)
        }
    }

    public func removeAllNodes() {
        head = nil
        tail = nil
    }

    public func remove(node: Node<T>) -> T {
        let prev = node.previous
        let next = node.next

        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev

        if next == nil {
            tail = prev
        }

        node.previous = nil
        node.next = nil

        return node.value
    }
}

let list1 = LinkedList<Int>()
let list2 = LinkedList<Int>()
let numArray1 = [2,4,3]
let numArray2 = [5,6,4]

list1.appendValues(values: numArray1)
list2.appendValues(values: numArray2)


//MARK: - LeetCode Add Two Numbers Problem
class ListNode: CustomStringConvertible {
    var value: Int
    var next: ListNode?

    var description: String {
        var text = "["
        var node = next

        while node != nil {
            text += "\(node!.value)"
            node = node!.next
            if node != nil { text += " -> " }
        }

        return text + "]"
    }


    init () {
        value = 0
        next = nil
    }

    init (nodeValue: Int, nodeNext: ListNode?) {
        value = nodeValue
        next = nodeNext
    }
}

func addNumbers(_ node1: ListNode?, node2: ListNode?) -> ListNode? {
    var temp1: ListNode? = node1
    var temp2: ListNode? = node2
    let dummy: ListNode = ListNode()
    var curr: ListNode = dummy
    var sum: Int = 0

    while temp1 != nil || temp2 != nil {
        sum /= 10
        if let n = temp1 {
            sum += n.value
            temp1 = n.next
        }

        if let n = temp2 {
            sum += n.value
            temp2 = n.next
        }

        curr.next = ListNode(nodeValue: sum % 10, nodeNext: nil)
        if let n = curr.next {
            curr = n
        }
    }

    if sum / 10 == 1 {
        curr.next = ListNode(nodeValue: 1, nodeNext: nil)
    }

    return dummy.next
}

let node1 = ListNode(nodeValue: 1, nodeNext: ListNode(nodeValue: 1, nodeNext: ListNode(nodeValue: 2, nodeNext: nil)))
let node2 = ListNode(nodeValue: 1, nodeNext: ListNode(nodeValue: 2, nodeNext: ListNode(nodeValue: 3, nodeNext: nil)))
print(node1)
print(node2)

print(addNumbers(node1, node2: node2))


