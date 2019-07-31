//
//  CalculatorViewModel.swift
//  CountOnMe
//
//  Created by Lauriane Haydari on 17/07/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

enum NextScreen: Equatable {
    case alert(title: String, message: String)
}

class CalculatorViewModel {
    
    // MARK: - Outputs
    
    var displayedText: ((String) -> Void)?
    
    var nextScreen: ((NextScreen) -> Void)?
    
    // MARK: - Inputs
    func viewDidLoad() {
        displayedText?("1+2=3")
    }
    
    func didPressOperand(operand: Int) {
        if let number = operandsString.last {
            var stringNumber = number
            stringNumber += "\(operand)"
            operandsString[operandsString.count-1] = stringNumber
            checkZeroDivision()
            checkEqualButtonTapped()
            getText()
            displayedText?(temporaryText)
        }
    }
    
    func didPressOperator(at index: Int) {
        guard index < operatorCases.count else {
            return
        }
        let stringOperator = operatorCases[index]
        operatorsString.append(stringOperator)
        operandsString.append("")
        checkEqualButtonTapped()
        getText()
        checkOperandBegin()
        displayedText?(temporaryText)
    }
    
    func didPressEqualButton(at tag: Int) {
        if tag == 4 {
            temporaryText.append("=\(getResult())")
            displayedText?(temporaryText)
            timesEqualButtonTapped = true
        }
    }
    
    func didPressClear() {
        clear()
    }
    
    func didPressDelete() {
        clearLast()
    }
    
    // MARK: Private properties
    
    private var operandsString: [String] = [String()]
    // start always positive
    private var operatorsString: [String] = ["+"]
    
    private let operatorCases = ["+",
                                 "-",
                                 "x",
                                 "/"]
    
    private var total: Double = 0
    
    private var timesEqualButtonTapped = false
    private var timesOperatorButtonTapped = [Int]()
    
    // MARK: - Private Functions
    
    var temporaryText = ""
    
    fileprivate func getText() {
        temporaryText = ""
        for (i, stringNumber) in operandsString.enumerated() {
            if i > 0 {
                temporaryText += operatorsString[i]
            }
            temporaryText += stringNumber
        }
    }
    
    fileprivate func getCalculPriorities() {
        var operanDs = operandsString
        var operatorS = operatorsString
        while operatorS.contains("x") || operatorS.contains("/") {
            if let indexOperator = operatorS.firstIndex (where: { $0 == "x" || $0 == "/" }) {
                let operatoR = operatorS[indexOperator]
                guard let operandLeft = Double(operanDs[indexOperator - 1]) else { return }
                guard let openrandRight = Double(operanDs[indexOperator]) else { return }
                if operatoR == "x" {
                    total = Double(operandLeft * openrandRight)
                } else {
                    total = Double(operandLeft / openrandRight)
                }
                print ("operators : \(operatorS)")
                operatorS.remove(at: indexOperator)
                
                operanDs[indexOperator - 1] = "\(total)"
                operanDs.remove(at: indexOperator)
                operandsString = operanDs
                print ("operandsString : \(operandsString)")
                operatorsString = operatorS
                print ("operators less x || / : \(operatorsString)")
            }
        }
    }
    
    fileprivate func calcul() -> Double {
        var result: Double = 0
        for (index, operands ) in operandsString.enumerated() {
            if let number = Double(operands) {
                if operatorsString[index] == "+" {
                    result += number
                } else if operatorsString[index] == "-" {
                    result -= number
                }
                print ("result : \(result)")
            }
        }
        resetArrays()
        return result
    }
    
    fileprivate func getResult() -> String {
        getCalculPriorities()
        let total = String(calcul())
        return total
    }
    
    fileprivate func clear() {
        resetArrays()
        temporaryText.removeAll()
        displayedText?(temporaryText)
        timesEqualButtonTapped = false
    }
    
    fileprivate func clearLast() {
        if temporaryText != "" {
            temporaryText.removeLast()
            displayedText?(temporaryText)
        }
    }
    
    fileprivate func resetArrays() {
        operatorsString = ["+"]
        operandsString =  [String()]
    }
    
    // MARK: - Alerts
   fileprivate func checkZeroDivision() {
        if let operands = operandsString.last {
            if operands == "0" && operatorsString.last == "/" {
                nextScreen?(.alert(title: "Alert", message: "Division par zéro impossible"))
                clear()
            }
        }
    }
    
    fileprivate func checkOperandBegin() {
        if let operands = operandsString.last {
            if operands.isEmpty {
                if let tempText = temporaryText.first {
                    if tempText == "+" || tempText == "-" || tempText == "x" || tempText == "/" {
                        nextScreen?(.alert(title: "Alert", message: "Entrez un chiffre!"))
                        clear()
                    }
                }
            }
        }
    }
    
    fileprivate func checkEqualButtonTapped() {
        if temporaryText.contains("=") {
            nextScreen?(.alert(title: "Alert", message: "Entrez une expression correcte!"))
            clear()
        }
    }
}


