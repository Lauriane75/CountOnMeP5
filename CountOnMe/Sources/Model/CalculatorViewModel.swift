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

final class CalculatorViewModel {

    // MARK: Private properties

    private var operandsString: [String] = [""]

    private var operatorsString: [String] = ["+"] // start always positive

    private let operatorCases = ["+",
                                 "-",
                                 "x",
                                 "/"]

    private var total: Double = 0

    private var timesEqualButtonTapped = false

    private var timesOperatorButtonTapped: [Int] = []

    // MARK: - Outputs
    
    var displayedText: ((String) -> Void)?
    
    var nextScreen: ((NextScreen) -> Void)?
    
    // MARK: - Inputs

    func viewDidLoad() {
        displayedText?("1+2=3")
    }
    
    func didPressOperand(operand: String) {
        
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

    func didPressDot() {
        
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
    
    // MARK: - Private Functions
    
    var temporaryText = ""
    
    private func getText() {
        temporaryText = ""
        for (i, stringNumber) in operandsString.enumerated() {
            if i > 0 {
                temporaryText += operatorsString[i]
            }
            temporaryText += stringNumber
        }
    }
    
    private func getCalculPriorities() {
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
    
    private func calcul() -> Double {
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
    
    private func getResult() -> String {
        getCalculPriorities()
        let numberformatter = NumberFormatter()
        numberformatter.minimumFractionDigits = 0
        numberformatter.maximumFractionDigits = 3
        guard let total = numberformatter.string(from: NSNumber(value: calcul())) else { return "" }
        return total
    }
    
    private func clear() {
        resetArrays()
        temporaryText.removeAll()
        displayedText?(temporaryText)
        timesEqualButtonTapped = false
    }
    
    private func clearLast() {
        if temporaryText != "" {
            temporaryText.removeLast()
            displayedText?(temporaryText)
        }
    }
    
    private func resetArrays() {
        operatorsString = ["+"]
        operandsString =  [String()]
    }
    
    // MARK: - Alerts

    private func checkZeroDivision() {
        if let operands = operandsString.last {
            if operands == "0" && operatorsString.last == "/" {
                nextScreen?(.alert(title: "Alert", message: "Division par zéro impossible"))
                clear()
            }
        }
    }
    
    private func checkOperandBegin() {
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
    
    private func checkEqualButtonTapped() {
        if temporaryText.contains("=") {
            nextScreen?(.alert(title: "Alert", message: "Entrez une expression correcte!"))
            clear()
        }
    }
}
