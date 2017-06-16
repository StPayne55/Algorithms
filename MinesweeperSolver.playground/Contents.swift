//: Playground - noun: a place where people can play

import UIKit

class Solution {
    func updateBoard(_ board: [[Character]], _ click: [Int]) -> [[Character]] {
        let m = board.count
        let n = board[0].count
        let row = click[0]
        let col = click[1]
        var board = board

        if board[row][col] == "M" {
            board[row][col] = "X"
            return board
        }

        var count = 0
        for i in -1..<2 {
            for j in -1..<2 {
                if i == 0 && j == 0 {
                    continue
                }
                let x = row + i
                let y = col + j
                if x < 0 || x >= m || y < 0 || y >= n {
                    continue
                }
                if board[x][y] == "M" || board[x][y] == "X" {
                    count += 1
                }
            }
        }

        if count > 0 {
            board[row][col] = Character(UnicodeScalar(count + 0)!)
        } else {
            board[row][col] = "B"
            for i in -1..<2 {
                for j in -1..<2 {
                    if i == 0 && j == 0 {
                        continue
                    }
                    let x = row + i
                    let y = col + j
                    if x < 0 || x >= m || y < 0 || y >= n {
                        continue
                    }
                    if board[x][y] == "E" {
                        board = updateBoard(board, [x, y])
                    }
                }
            }
        }

        return board
    }

    func updateBoard_BFS(_ board: [[Character]], _ click: [Int]) -> [[Character]] {
        let m = board.count
        let n = board[0].count
        var board = board
        var queue = [click]

        while !queue.isEmpty {
            let cell = queue.removeLast()
            let row = cell[0]
            let col = cell[1]

            if board[row][col] == "M" {
                board[row][col] = "X"
            } else {
                var count = 0
                for i in -1..<2 {
                    for j in -1..<2 {
                        if i == 0 && j == 0 {
                            continue
                        }
                        let x = row + i
                        let y = col + j
                        if x < 0 || x >= m || y < 0 || y >= n {
                            continue
                        }
                        if board[x][y] == "M" || board[x][y] == "X" {
                            count += 1
                        }
                    }
                }

                if count > 0 {
                    board[row][col] = Character(UnicodeScalar(count + 0)!)
                } else {
                    board[row][col] = "B"
                    for i in -1..<2 {
                        for j in -1..<2 {
                            if i == 0 && j == 0 {
                                continue
                            }
                            let x = row + i
                            let y = col + j
                            if x < 0 || x >= m || y < 0 || y >= n {
                                continue
                            }
                            if board[x][y] == "E" {
                                board = updateBoard(board, [x, y])
                            }
                        }
                    }
                }
            }
        }

        return board;
    }
}
