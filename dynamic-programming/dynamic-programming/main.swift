//
//  main.swift
//  dynamic-programming
//
//  Created by Marat Khanbekov on 31.12.2020.
//

import Foundation

print("Hello, World!")


// 3. ***Требуется обойти конем шахматную доску размером NxM, пройдя через все поля доски по одному разу. Здесь алгоритм решения такой же, как в задаче о 8 ферзях. Разница только в проверке положения коня.

typealias Board = [[Int]]

func createBoard(_ N: Int, _ M: Int) -> Board {
    var board: [[Int]] = []
    for _ in 0..<N {
        var row: [Int] = []
        for _ in 0..<M {
            row.append(0)
        }
        board.append(row)
    }
    return board
}

func showBoard(_ board: Board) {
    print("Board State:")
    for n in 0...board.count-1 {
        print(board[n])
    }
}

func makeMove(_ board: Board, n: Int, m: Int) -> Board {
    var _board = board
    _board[n][m] = 1
    return _board
}


func findCurrentPosition(_ board: Board) -> [Int] {
    let N = board[0].count
    let M = board.count
    
    var currentMoveNumber = 0
    var currentPosition: [Int] = [0, 0]
    
    for n in 0..<N {
        for m in 0..<M {
            if board[n][m] > currentMoveNumber {
                currentPosition[0] = n
                currentPosition[1] = m
                currentMoveNumber = board[n][m]
            }
        }
    }
    
    return currentPosition
}



func findMovements(_ board: Board) -> [[Int]] {
    
    var movements: [[Int]] = []
    
    let N = board.count
    let M = board[0].count
    
    let currentPosition = findCurrentPosition(board)
    let n = currentPosition[0]
    let m = currentPosition[1]
    
    let steps = [-2, -1, 1, 2]

    for nstep in steps {
        
        let nMadenStep = n + nstep
        
        for mstep in steps {
            
            let mMadenStep = m + mstep
            
            if (abs(Double(nstep)/Double(mstep)) == 0.5 || abs(Double(nstep)/Double(mstep)) == 2)
                && nMadenStep >= 0
                && nMadenStep < N
                && mMadenStep >= 0
                && mMadenStep < M
                && board[nMadenStep][mMadenStep] == 0
                {
                movements.append([nMadenStep, mMadenStep])
                }
        }
    }
    return movements
}

func isBoardCompleted(_ board: Board) -> Bool {
    for n in 0..<board[0].count {
        for m in 0..<board.count {
            if board[n][m] == 0 {
                return false
            }
        }
    }
    return true
}

func fastSearchForSolution(_ board: Board, nextMoveNumber: Int = 2) {
    if isBoardCompleted(board) {
        showBoard(board)
    }

    let movements = findMovements(board)
    
    var moveEstimation: [Int] = []
    for move in movements {
        let tempBoard = makeMove(board, n: move[0], m: move[1])
        let possibleMoves = findMovements(tempBoard).count
        moveEstimation.append(possibleMoves)
    }
    
    if movements.count == 0 {
        return
    }
    
    for e in 0..<moveEstimation.count {
        if moveEstimation[e] < 3 {
            var _board = board
            _board[movements[e][0]][movements[e][1]] = nextMoveNumber
            fastSearchForSolution(_board, nextMoveNumber: nextMoveNumber + 1)
        }
    }
}

func searchForAllSolutions(_ board: Board, nextMoveNumber: Int = 2) {
    if isBoardCompleted(board) {
        showBoard(board)
    }
    
    let movements = findMovements(board)
    
    if movements.count == 0 {
        return
    }
    
    for c in 0..<movements.count {
        var _board = board
        _board[movements[c][0]][movements[c][1]] = nextMoveNumber
        searchForAllSolutions(_board, nextMoveNumber: nextMoveNumber + 1)
    }
}

// Create board
var board = createBoard(5, 5)

// Make first move
board = makeMove(board, n: board.count/2, m: board[0].count/2)

// Search for all solutions
searchForAllSolutions(board)

// Super fast solution
//fastSearchForSolution(board)
