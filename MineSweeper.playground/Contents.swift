import UIKit

class Square: CustomStringConvertible {
    var description: String {
        return "Row: \(row), Column: \(column), isMine: \(isMine), nearbyMines: \(surroundingMines)\n"
    }

    let row: Int
    let column: Int
    var surroundingMines = 0
    var isMine = false
    var isSelected = false

    init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
}

var grid = [[Square]]()

func createGridOfSquares() {
    for i in 0..<gridSize {
        var squareRow = [Square]()
        for j in 0..<gridSize {
            let s = Square(row: i, column: j)
            isMineLocation(square: s)
            squareRow.append(s)
        }

        grid.append(squareRow)
    }

    for row in grid {
        for square in row {
            numberOfMinesNearSquare(square: square)
        }
    }
}

func isMineLocation(square: Square) {
    square.isMine = ((arc4random() % 2) == 0)
}

func numberOfMinesNearSquare(square: Square) {
    let nearbySquares = getSurroundingSquares(square: square)

    var nearbyMines = 0
    for square in nearbySquares {
        if square.isMine {
            nearbyMines += 1
        }
    }
    square.surroundingMines = nearbyMines
}

func getSurroundingSquares(square: Square) -> [Square] {
    var nearbySquares = [Square]()

    let offsets = [(-1,-1), (0,-1), (1,-1), (-1,0), (1,0), (-1, 1), (0,1), (1,1)]

    for (x, y) in offsets {
        let nearbySquare: Square? = squareForPoint(x: square.row + x, y: square.column + y)
        if let n = nearbySquare {
            nearbySquares.append(n)
        }
    }

    return nearbySquares
}

func squareForPoint(x: Int, y: Int) -> Square? {
    if x >= 0 && x < gridSize && y >= 0 && y < gridSize {
        return grid[x][y]
    } else {
        return nil
    }
}

let gridSize = 10
createGridOfSquares()
let s = grid[5][5]
print(getSurroundingSquares(square: s))

