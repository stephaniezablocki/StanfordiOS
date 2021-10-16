//
//  ViewController.swift
//  Calculator
//
//  Created by Stephanie Zablocki on 10/13/21.
//  Copyright © 2021 Stephanie Zablocki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    private var alreadyADecimal = false
    
    private func isValidNumber(next: String) -> Bool {
        if next != "." {
            return true
        }
        else if !alreadyADecimal {
            alreadyADecimal = true
            return true
        }
        else {
            return false
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if isValidNumber(next: digit) {
            if userIsInTheMiddleOfTyping {
                let textCurrentlyInDisplay = display.text!
                display.text = textCurrentlyInDisplay + digit
            }
            else {
                display.text = digit
                userIsInTheMiddleOfTyping = true
            }
        }
    }
    
    private func handleDecimal() {
        
    }
    
    var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
            alreadyADecimal = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
    }
}

