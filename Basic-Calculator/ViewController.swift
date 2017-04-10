//
//  ViewController.swift
//  Basic-Calculator
//
//  Created by Arun Ramaswamy on 4/5/17.
//  Copyright © 2017 Arun Ramaswamy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

 
    @IBOutlet weak var display: UILabel?
    
    var userIsInMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        var digit = sender.currentTitle!
        if (userIsInMiddleOfTyping){
            let textCurrentlyinDisplay = display!.text!
            display!.text = textCurrentlyinDisplay + digit
        }
        else{
             display!.text = digit
             userIsInMiddleOfTyping = true;
        }
    }
    
    var displayValue : Double{
        get{
            return Double(display!.text!)!
        }
        set{
            display!.text = String(newValue)
        }
    }
    @IBAction func performOperation(_ sender: UIButton) {
        userIsInMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle{
            switch mathematicalSymbol {
                case "π":
                    displayValue = Double.pi
                case "√" :
                    displayValue = sqrt(displayValue )
                
                default:
                    break
            }
        }

    }
}
 
