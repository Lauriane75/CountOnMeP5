//
//  ViewModel.swift
//  CountOnMe
//
//  Created by Lauriane Haydari on 17/07/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class ViewModel {
    
    // MARK: - Outputs
    
    var displayedText: ((String) -> Void)?
    
    // MARK: - Private properties
    
    private var stringElement: String {
        return String(elements.joined(separator: " "))
    }
     var elements: [String] {
        return temporaryText.split(separator: " ").map { "\($0)" }
    }
    private var temporaryText = ""
    //
//    private var temporaryText: [String] = [] {
//        didSet {
//            displayedText?(temporaryText.joined(separator: " "))
//        }
//    }
    
    // Error check computed variables
    private var expressionIsCorrect: Bool {
        return elements.last != " + " && elements.last != " - "
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var canAddOperator: Bool {
        return elements.last != " + " && elements.last != " - "
    }
    
    private var expressionHaveResult: Bool {
        return elements.firstIndex(of: "=") != nil
    }
    
     var left: Double {
        return Double(elements[0])!
    }
    
     var right: Double {
        return Double(elements[2])!
    }
     var operand: String {
        return (elements[1])
    }

    // MARK: - Inputs
    
    func viewDidLoad() -> Void {
        displayedText?("1 + 2 = 3")
    }
    
    // buttons
    // Equal Button
    func didPressEqualButton() {
    var operationsToReduce = elements
        while operationsToReduce.count > 1 {
            var result: Double
            for (_, _) in operationsToReduce.enumerated() {
                if operand == "+" {
                    result = left + right
                } else if operand == "-" {
                    result = left - right
                } else if operand == "x" {
                    result = left * right
                } else if operand == "/" {
                    result = left / right
                } else {
                    fatalError("Unknown operator !")
                }
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                print("operationsToReduce 1 : \(operationsToReduce)")
                // show after index 3 so from second operand
                operationsToReduce.insert("\(result)", at: 0)
                print("operationsToReduce 2 : \(operationsToReduce)")
            }
            temporaryText.append(" = \(operationsToReduce.first!)")
        }
        // debug
        print("temporaryText : \(temporaryText)")
        print("elements : \(elements)")
        print("stringElement : \(stringElement)")
        displayedText?(stringElement)
    }
    
    // Number Buttons
    func didPressNumberButton(with numberText: String) {
        print(temporaryText)
        if expressionHaveResult {
        }
        temporaryText.append(numberText)
        displayedText?(stringElement)
    }
    
    // Operator Button
    private var operatorsArray: [String] = [" + ", " - ", " x ", " / "]
    
    func didSelectOperator(at index: Int) {
        if canAddOperator {
            guard index < operatorsArray.count else {
                return
            }
            temporaryText.append(operatorsArray[index])
            print(operatorsArray[index])
        }
        displayedText?(stringElement)
    }
    
    // Remove Button
    func didPressRemoveButton() {
        temporaryText.removeAll()
        displayedText?(stringElement)
    }
    
    // Return Button
    func didPressReturnButton() {
        temporaryText.removeLast()
        displayedText?(stringElement)
    }
    
} // end
