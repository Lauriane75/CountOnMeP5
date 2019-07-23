//
//  ViewModel.swift
//  CountOnMe
//
//  Created by Lauriane Haydari on 17/07/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

class ViewModel {

    // MARK: - Outputs
    
    var displayedText: ((String) -> Void)?

    var nextScreen: ((Screen) -> Void)?
    
    // MARK: - Properties
    
    var stringElement: String {
        return String(elements.joined(separator: " "))
    }
    
    var elements: [String] {
        return temporaryText.split(separator: " ").map { "\($0)" }
    }
    
    var temporaryText = ""
    
    var expressionHaveEnoughElement: Bool {
        return elements.count > 4
    }
    
    var lastElementIsNotAnOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    var firstElementIsAnOperator: Bool {
        return elements.first == "+" || elements.first == "-" || elements.first == "x" || elements.first == "/"
    }
    
    var expressionHaveResult: Bool {
        return elements.firstIndex(of: "=") != nil
    }
    
    var left: Double {
        return Double(elements[0])!
    }
    
    var right: Double {
        return Double(elements[2])!
    }
    
    var result: Double = 0
    
    var operand: String {
        return (elements[1])
    }
    
    var selectOperator: OperatorCase = .addition {
        didSet {
        }
    }
    
    var timesEqualButtonTapped = [Int]()
//    var timesOperatorButtonTapped = [Int]()
    

    // MARK: - Inputs
    func viewDidLoad() {
        displayedText?("1 + 2 = 3")
    //    Alert.init(type: .operationError)
    }
    
    // buttons
    // Equal Button
    fileprivate func startANewCalcul() {
        if temporaryText.last != nil {
            temporaryText.removeAll()
        }
        displayedText?("")
    }
    
    func didPressEqualButton() {
        timesEqualButtonTapped.append(+1)
        var operationsToReduce = elements
        if operationsToReduce.count < 3 {
             nextScreen?(.alert(title: "OK", message: "Entrez un calcul correcte"))
            displayedText?(stringElement)
        }
        if timesEqualButtonTapped.count > 1 {
            nextScreen?(.alert(title: "OK", message: "Vous avez déjà fait une opération. Démarrez un nouveau calcul !"))
        startANewCalcul()
        } else if expressionHaveEnoughElement {
            timesEqualButtonTapped.removeAll()
            nextScreen?(.alert(title: "OK", message: "Démarrez un nouveau calcul !"))
         startANewCalcul()
        } else {
            while operationsToReduce.count > 1 {
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
                        nextScreen?(.alert(title: "OK", message: "Entrez un calcul correcte"))
                         startANewCalcul()
                    }
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                print("operationsToReduce 1 : \(operationsToReduce)")
                // show after index 3 so from second operand
                operationsToReduce.insert("\(result)", at: 0)
                print("operationsToReduce 2 : \(operationsToReduce)")
                }
            temporaryText.append("\(operationsToReduce.first!)")
            // debug
            print("temporaryText : \(temporaryText)")
            print("elements : \(elements)")
            print("stringElement : \(stringElement)")
            displayedText?(stringElement)
            }
        timesEqualButtonTapped.removeAll()
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
        if lastElementIsNotAnOperator {
            guard index < operatorsArray.count else {
                return
            }
            temporaryText.append(operatorsArray[index])
            print(operatorsArray[index])
        } else if firstElementIsAnOperator {
            nextScreen?(.alert(title: "OK", message: "Ajouter un chiffre"))
        //    temporaryText.removeAll()
        }
        if index == 4 {
            didPressEqualButton()
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
