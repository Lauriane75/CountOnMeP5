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

    var nextScreen: ((Screen) -> Void)?

    enum Screen {
        case alert(title: String, message: String)
    }
    
    // MARK: - Private properties
    
    private var stringElement: String {
        return String(elements.joined(separator: " "))
    }
    private var elements: [String] {
        return temporaryText.split(separator: " ").map { "\($0)" }
    }
    private var temporaryText = ""
    
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count > 4
    }
    
    private var canAddOperator: Bool {
        return elements.last != " + " && elements.last != " - " && elements.last != " x " && elements.last != " / "
    }
    
    private var expressionHaveResult: Bool {
        return elements.firstIndex(of: "=") != nil
    }
    
    // MARK: - Properties
    
     var left: Double {
        return Double(elements[0])!
    }
    
     var right: Double {
        return Double(elements[2])!
    }
    
     var operand: String {
        return (elements[1])
    }
    
    enum OperatorCase {
        case addition, substraction, multiplication, division
    }
    
    var selectOperator: OperatorCase = .addition {
        didSet {
        }
    }
    
    var timesEqualButtonTapped = [Int]()


    // MARK: - Inputs
    
    
    func viewDidLoad() {
        displayedText?("1 + 2 = 3")
    }
    
    // buttons
    // Equal Button
    func didPressEqualButton() {
        // nextScreen?(.alert(title: "OK", message: "Ajoutez un chiffre"))
        if expressionHaveEnoughElement {
            nextScreen?(.alert(title: "OK", message: "Démarrez un nouveau calcul !"))
            temporaryText.removeAll()
            displayedText?("")
        } else {
            var operationsToReduce = elements
            while operationsToReduce.count > 1 {
                var result: Double
                for (_, _) in operationsToReduce.enumerated() {
                    if operand == "+" {
                        selectOperator = .addition
                        result = left + right
                    } else if operand == "-" {
                        selectOperator = .substraction
                        result = left - right
                    } else if operand == "x" {
                         selectOperator = .multiplication
                        result = left * right
                    } else if operand == "/" {
                         selectOperator = .division
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
                temporaryText.append("\(operationsToReduce.first!)")
            }
            if timesEqualButtonTapped.count > 1 {
                print ("recalcule")
            }
            // debug
            print("temporaryText : \(temporaryText)")
            print("elements : \(elements)")
            print("stringElement : \(stringElement)")
            displayedText?(stringElement)
        }
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
    private var operatorsArray: [String] = [" + ", " - ", " x ", " / ", " = "]
    
    func didSelectOperator(at index: Int) {
        if canAddOperator {
            guard index < operatorsArray.count else {
                return
            }
            temporaryText.append(operatorsArray[index])
            print(operatorsArray[index])
     //   } else if  {
         //   nextScreen?(.alert(title: "Zéro", message: "Un operateur est déja mis !"))
        }
        displayedText?(stringElement)
    }
    
    // Remove Button
    func didPressClear() {
         if temporaryText.last != nil {
             temporaryText.removeAll()
        }
        displayedText?("")
    }
    
    // Return Button
    func didPressReturnButton() {
        if temporaryText.last != nil {
            temporaryText.removeLast()
        }
        displayedText?(stringElement)
    }
    
} // end
