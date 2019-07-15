//
//  brainCalculator.swift
//  CountOnMe
//
//  Created by Lauriane Haydari on 12/07/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Braincalculator {
    
    let vcl = ViewController()
    
    func set() {
        
    }
    
    var elementOnScreen : [String]
    // from vcl
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elementOnScreen.last != "+" && elementOnScreen.last != "-"
    }
    var expressionHaveEnoughElement: Bool {
        return elementOnScreen.count >= 3
    }
    
    var canAddOperator: Bool {
        return elementOnScreen.last != "+" && elementOnScreen.last != "-"
    }
    
    
    init (elementOnScreen: [String]) {
        self.elementOnScreen = elementOnScreen
    }
    
    func setElementOnScreen() -> [String] {
        return vcl.elements
    }
    
    
}
