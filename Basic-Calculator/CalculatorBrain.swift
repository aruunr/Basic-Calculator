//
//  CalculatorBrain.swift
//  Basic-Calculator
//
//  Created by Arun Ramaswamy on 4/11/17.
//  Copyright © 2017 Arun Ramaswamy. All rights reserved.
//

import Foundation


func multiply(op1:Double,op2:Double) -> Double{
    return op1 * op2
}

struct CalculatorBrain {

    private var accumulator : Double?

    private enum Operation{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    
    
    private var operations : Dictionary<String,Operation> =
        [
            "π" : Operation.constant(Double.pi),
            "√" : Operation.unaryOperation(sqrt),
            "cos" : Operation.unaryOperation(cos),
            "x" : Operation.binaryOperation(multiply),
            "=" : Operation.equals
        ]
    
    
    
    mutating func performOperation(_ symbol : String){
        if let operation = operations[symbol]{
            switch operation {
            case .constant(let value):
                    accumulator = value
            case .unaryOperation(let function) :
                if accumulator != nil{
                accumulator = function(accumulator!)
                }
            case .binaryOperation(let function) :
                if accumulator != nil{
                    pbo = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals :
                performPendingBinaryoperation()
            }
        }
    }
    
    mutating func performPendingBinaryoperation(){
        if pbo != nil && accumulator != nil{
            accumulator = pbo!.perform(with :accumulator!)
            pbo = nil
        }
    }
    
    private var pbo : PendingBinaryOperation?
    
    private struct PendingBinaryOperation{
        let function : (Double,Double) -> Double
        let firstOperand : Double
        func perform(with secondOperand:Double) -> Double {
        return function (firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand : Double ){
        accumulator = operand
    }
    
    var result : Double? {
        get {
            return accumulator
        }
    }
}
