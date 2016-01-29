//
//  ViewController.swift
//  A2
//
//  Created by YangYang on 2016-01-15.
//  Copyright © 2016 YangYang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var brain = SudokuMainController()
    var question : [[Int]] = []
    var quesAnsw : [[Int]] = []
    var buttonPos = 100

    @IBOutlet weak var RWnotice: UILabel!
    @IBOutlet weak var PosiableNumber: UILabel!
    @IBOutlet var GridButton: [UIButton]!

    @IBAction func GridTouched(sender: UIButton) {
        let x = GridButton.indexOf(sender)!
        if sender.currentTitle == "0" {
            var pos: [Int] = brain.getPosition(x)
            
            //for all possiable number in valid postion
            var possiable : [Int] = []
            for k in 1...9 {
                if brain.ifValid(question, row: pos[0], col: pos[1], checkValue: k) {
                    possiable.append(k)
                }
            }
            PosiableNumber.text = String(possiable)
            buttonPos = x
        }else{
            PosiableNumber.text = "Cheater!"
            buttonPos = 100
        }
    }
    
    @IBAction func NewGame(sender: UIButton) {
        brain.setSudoku()
        question = brain.getQue()
        brain.solveGrid(question, row: 0, col: 0)
        quesAnsw = brain.getAns()
        var k = 0
        for i in 0...8 {
            for j in 0...8 {
                GridButton[k].setTitleColor(UIColor.redColor(), forState: .Normal)
                GridButton[k].setTitle(String(question[i][j]), forState: .Normal)
                GridButton[k].layer.borderWidth = 3
                GridButton[k].layer.cornerRadius = 10
                GridButton[k].layer.borderColor = UIColor.blackColor().CGColor
                k++
            }
        }
    }
    
    @IBAction func ShowAns(sender: UIButton) {
        question = brain.getAns()
        var k = 0
        for i in 0...8 {
            for j in 0...8 {
                GridButton[k].setTitleColor(UIColor.redColor(), forState: .Normal)
                GridButton[k].setTitle(String(question[i][j]), forState: .Normal)
                GridButton[k].layer.borderWidth = 3
                GridButton[k].layer.cornerRadius = 10
                GridButton[k].layer.borderColor = UIColor.blackColor().CGColor
                k++
            }
        }
    }
    
    @IBAction func FillNumber(sender: UIButton) {
        if buttonPos != 100 {
            let x = Int(sender.currentTitle!)!
            let y = brain.getPosition(buttonPos)
            if x == quesAnsw[(y[0])][(y[1])] {
                GridButton[buttonPos].setTitle(sender.currentTitle, forState: .Normal)
                RWnotice.text = "You are right!"
            }else{
                RWnotice.text = "Your are wrong!"
            }
        }
        
        var winningcheck = 0
        for i in 0...80 {
            if GridButton[i].currentTitle! == "0" {
                winningcheck++
            }
        }
        if winningcheck == 0 {
            let alertController = UIAlertController(title: "You Won!", message: "You are the best!", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "I am the BEST!", style: .Default) { (action) in }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true) { }
        }
    }
}

