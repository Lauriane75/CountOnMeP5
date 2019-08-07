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
                                 "/",
                                 "="]

    private var temporaryText = ""

    private var total: Double = 0

    private var timesEqualButtonTapped = false

    // MARK: - Outputs

    var displayedText: ((String) -> Void)?

    var nextScreen: ((NextScreen) -> Void)?

    // MARK: - Inputs

    func viewDidLoad() {
        displayedText?("1+2=3")
        temporaryText = ""
    }

    func didPressOperand(operand: Int) {
        if let number = operandsString.last {
            var stringNumber = number
            stringNumber += "\(operand)"
            operandsString[operandsString.count-1] = stringNumber
            checkEqualButtonTapped()
            getText()
            displayedText?(temporaryText)
        }
    }
    func didPressOperator(at index: Int) {
        guard !temporaryText.isEmpty else {
            nextScreen?(.alert(title: "Alerte", message: "Commencez par un chiffre!"))
            return
        }
        guard let lastElement = temporaryText.last?.description, !operatorCases.contains(lastElement) else {
            nextScreen?(.alert(title: "Alerte", message: "Entrez un chiffre après un opérateur!"))
            return
        }
        guard index < operatorCases.count else {
            return
        }
        let stringOperator = operatorCases[index]

        if stringOperator == "=" {
            guard !temporaryText.contains("=") else {
                nextScreen?(.alert(title: "Alerte", message: "Opération terminée!"))
                return
            }
            processCalcul()
        } else {
            operatorsString.append(stringOperator)
            operandsString.append("")
            checkEqualButtonTapped()
            getText()
            checkOperandBegin()
            displayedText?(temporaryText)
        }
    }

    func didPressDotButton() {
        let dot = "."
        if let number = operandsString.last {
            var decimal = number
            if let comma = decimal.last {
                if comma != dot.last {
                    if decimal == dot { decimal = "0\(dot)"}
                    decimal = (decimal) + dot
                    print ("decimal: \(decimal)")
                    operandsString[operandsString.count-1] = decimal
                    getText()
                    displayedText?(temporaryText)
            } else {
                nextScreen?(.alert(title: "Alerte", message: "Ajoutez un chiffre après une virgule!"))
                clear()
                }
            }
        }
    }

    func didPressClear() {
        clear()
    }

    func didPressDelete() {
        clearLast()
    }

    // MARK: - Private Functions

    private func getText() {
        temporaryText = ""
        for (index, stringNumber) in operandsString.enumerated() {
            if index > 0 {
                temporaryText += operatorsString[index]
            }
            temporaryText += stringNumber
        }
        print ("temporaryText get text: \(temporaryText)")
        displayedText?(temporaryText)
    }

    func processCalcul() {
        checkZeroDivision()
        let total = getResult()
        if total.first == "." {
            temporaryText.append("=0\(total)")
        } else {
            temporaryText.append("=\(total)")
        }
        displayedText?(temporaryText)
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
                // debug
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
                // debug
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
                nextScreen?(.alert(title: "Alerte", message: "Division par zéro impossible"))
                clear()
            }
        }
    }
    private func checkOperandBegin() {
        if let operands = operandsString.last {
            if operands.isEmpty {
                if let tempText = temporaryText.first {
                    if tempText == "+" || tempText == "-" || tempText == "x" || tempText == "/" {
                        nextScreen?(.alert(title: "Alerte", message: "Commencez par un chiffre!"))
                        clear()
                    }
                }
            }
        }
    }
    private func checkEqualButtonTapped() {
        if temporaryText.contains("=") {
            nextScreen?(.alert(title: "Alerte", message: "Entrez une expression correcte!"))
            clear()
        }
    }
}
