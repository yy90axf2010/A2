//
//  SudokuMainController.swift
//  A2
//
//  Created by YangYang on 2016-01-16.
//  Copyright © 2016 YangYang. All rights reserved.
//

import Foundation

class SudokuMainController {
    
    var setgame = false
    var sudoku : [[Int]] = [[0,0,3,0,2,0,6,0,0],
        [9,0,0,3,0,5,0,0,1],
        [0,0,1,8,0,6,4,0,0],
        [0,0,8,1,0,2,9,0,0],
        [7,0,0,0,0,0,0,0,8],
        [0,0,6,7,0,8,2,0,0],
        [0,0,2,6,0,9,5,0,0],
        [8,0,0,2,0,3,0,0,9],
        [0,0,5,0,1,0,3,0,0]]
    var sudokuAns : [[Int]] = []
    var dataBase : [Character] = []
    

    
    func solveGrid (var grid: [[Int]], row : Int, col:Int) {
        if row == 9 && col == 0 {
            sudokuAns = grid
            EXIT_SUCCESS
        }else{
            if grid[row][col] != 0 {
                if col == 8{
                    solveGrid(grid, row: row+1, col: 0)
                }else{
                    solveGrid(grid, row: row, col: col+1)
                }
            }else{
                for i in 1...9{
                    if ifValid(grid, row: row, col: col, checkValue: i){
                        grid[row][col] = i
                        if col == 8{
                            solveGrid(grid, row: row+1, col: 0)
                        }else{
                            solveGrid(grid, row: row, col: col+1)
                        }
                        grid[row][col] = 0
                    }
                }
            }
        }
    }
    
    func ifValid (grid : [[Int]], row:Int,col:Int,checkValue:Int) -> Bool{
        var ifvalid = true
        for i in 0...8{
            if grid[i][col] == checkValue {
                ifvalid = false
            }
            if grid[row][i] == checkValue {
                ifvalid = false
            }
        }
        let boxRow = (row / 3) * 3
        let boxCol = (col / 3) * 3
        for i in 0...2{
            for j in 0...2{
                if grid[boxRow + i][boxCol + j] == checkValue {
                    ifvalid = false
                }
            }
        }
        return ifvalid
    }
    
    func loadDatabase() {
        
        let filePaht = NSBundle .mainBundle()
        let dirReally = filePaht.pathForResource("question", ofType: "txt")!
        
        //print(dirReally)
        
        let fileContent = try! NSString(contentsOfFile: dirReally, encoding: NSUTF8StringEncoding)
        let x = String(fileContent)
        let char = Array(x.characters)
        for var i = 0; i < char.count; i++ {
            if char[i] == "G" {
                i = i + 7
            }else if char[i] != "\n"{
                dataBase.append(char[i])
            }
        }
    }
    
    func setSudoku(){
        if dataBase.count == 0 {
            loadDatabase()
            for i in 0...8 {
                for j in 0...8{
                    sudoku[i][j] = Int(String(dataBase.removeFirst()))!
                }
            }
        }else{
            for i in 0...8 {
                for j in 0...8{
                    sudoku[i][j] = Int(String(dataBase.removeFirst()))!
                }
            }
        }
    }
    
    func getQue() -> [[Int]]{
        return sudoku
    }
    
    func getAns()->[[Int]]{
        solveGrid(sudoku, row: 0, col: 0)
        return sudokuAns
    }
    
    func getPosition(var x : Int) -> [Int] {
        var i = 0
        var j = 0
        var array : [Int] = []
        if x <= 8 {
            i = 0
            j = x
        }else{
            while x > 8 {
                x = x-9
                i++
            }
            j = x
        }
        array.append(i)
        array.append(j)
        return array
    }
}