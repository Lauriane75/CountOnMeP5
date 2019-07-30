//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Lauriane Haydari on 22/07/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

@testable import CountOnMe

import XCTest

final class ViewModelTests: XCTestCase {
    
    var viewModel: CalculatorViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = CalculatorViewModel()
    }
    
    // viewModel.viewDidLoad() => displayedText("1 + 2 = 3")
    func testGivenAViewModelWhenViewDidLoadThenDisplayedTextIsCorrctlyReturned() {
        let expectation = self.expectation(description: "Returned text")
        viewModel.displayedText = { text in
            XCTAssertEqual(text, "1+2=3")
            expectation.fulfill()
        }
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGiven2Minus1WhendidPressEqualButtonThendisplayTextResultIs1() {
        let expectation = self.expectation(description: "Returned text")
        
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 4 {
                XCTAssertEqual(text, "2-1=1.0")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 2)
        viewModel.didPressOperator(at: 1)
        viewModel.didPressOperand(operand: 1)
        
        viewModel.didPressEqualButton(at: 4)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGiven2MultiplyBy3WhendidPressEqualButtonThendisplayTextResultIs6() {
        let expectation = self.expectation(description: "Returned text")
        
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 4 {
                XCTAssertEqual(text, "2x3=6.0")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 2)
        viewModel.didPressOperator(at: 2)
        viewModel.didPressOperand(operand: 3)
        
        viewModel.didPressEqualButton(at: 4)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGiven4AdditionTo2AddtionTo9WhendidPressEqualButtonThendisplayTextResultIs2() {
        let expectation = self.expectation(description: "Returned text")
        
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 6 {
                XCTAssertEqual(text, "4+2+9=15.0")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 4)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 2)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 9)
        viewModel.didPressEqualButton(at: 4)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGiven4DivideBy2WhendidPressEqualButtonThendisplayTextResultIs2() {
        let expectation = self.expectation(description: "Returned text")
        
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 4 {
                XCTAssertEqual(text, "4/2=2.0")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 4)
        viewModel.didPressOperator(at: 3)
        viewModel.didPressOperand(operand: 2)
        
        viewModel.didPressEqualButton(at: 4)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGiven2Addition3WhenDidPressEqualButtonThenDisplayTextResultIs5() {
        let expectation = self.expectation(description: "Returned text")
        
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 4 {
                XCTAssertEqual(text, "2+3=5.0")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 2)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 3)
        
        viewModel.didPressEqualButton(at: 4)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    // + -
    func testGiven2Plus4Minus1Plus8WhenDidPressEqualButtonThendisplayTextResultIs13() {
        
        let expectation = self.expectation(description: "Returned text")
        
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 8 {
                XCTAssertEqual(text, "2+4-1+8=13.0")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 2)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 4)
        viewModel.didPressOperator(at: 1)
        viewModel.didPressOperand(operand: 1)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 8)
        
        viewModel.didPressEqualButton(at: 4)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    // x +
    func testGiven2Multiply4Plus1WhenDidPressEqualButtonThendisplayTextResultIs9() {
        
        let expectation = self.expectation(description: "Returned text")
        
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 6 {
                XCTAssertEqual(text, "2x4+1=9.0")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 2)
        viewModel.didPressOperator(at: 2)
        viewModel.didPressOperand(operand: 4)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 1)
        
        viewModel.didPressEqualButton(at: 4)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    // x -
    func testGiven2Multiply4Minus1WhenDidPressEqualButtonThendisplayTextResultIs9() {
        
        let expectation = self.expectation(description: "Returned text")
        
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 6 {
                XCTAssertEqual(text, "2x4-1=7.0")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 2)
        viewModel.didPressOperator(at: 2)
        viewModel.didPressOperand(operand: 4)
        viewModel.didPressOperator(at: 1)
        viewModel.didPressOperand(operand: 1)
        
        viewModel.didPressEqualButton(at: 4)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    // x + /
    func testGiven2Multiply4Plus1DivideBy2WhenDidPressEqualButtonThendisplayTextResultIs8Comma5() {
        
        let expectation = self.expectation(description: "Returned text")
        
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 8 {
                XCTAssertEqual(text, "2x4+1/2=8.5")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 2)
        viewModel.didPressOperator(at: 2)
        viewModel.didPressOperand(operand: 4)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 1)
        viewModel.didPressOperator(at: 3)
        viewModel.didPressOperand(operand: 2)
        
        viewModel.didPressEqualButton(at: 4)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    // x - /
    func testGiven2Multiply4Minus1DivideBy2WhenDidPressEqualButtonThendisplayTextResultIs8Comma5() {
        
        let expectation = self.expectation(description: "Returned text")
        
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 8 {
                XCTAssertEqual(text, "2x4-1/2=7.5")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 2)
        viewModel.didPressOperator(at: 2)
        viewModel.didPressOperand(operand: 4)
        viewModel.didPressOperator(at: 1)
        viewModel.didPressOperand(operand: 1)
        viewModel.didPressOperator(at: 3)
        viewModel.didPressOperand(operand: 2)
        
        viewModel.didPressEqualButton(at: 4)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGiven5Addition2Is5WhenDidPressclearButtonThenDisplayedTextIsCorrctlyCleared() {
        
        let expectation = self.expectation(description: "Returned text")
        
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 4 {
                XCTAssertEqual(text, "")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 5)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 2)
        
        viewModel.didPressClear()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    // delete button
    // à changer (trouver une solution pour les espaces
    func testGiven5AdditionWhenDidPressDeleteButtonThenDisplayedTextIsCorrectlyDeleted() {
        
        let expectation = self.expectation(description: "Returned text")
        
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 4
{
                XCTAssertEqual(text, "5+")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 5)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 2)
        
        viewModel.didPressDelete()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGiven3DivideBy0WhendidPressEqualButtonThenAlertError() {
        let expectation = self.expectation(description: "Returned alert")
        
        viewModel.nextScreen = { screen in
            XCTAssertEqual(screen, .alert(title: "Alert", message: "Division par zéro impossible"))
            expectation.fulfill()
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 3)
        viewModel.didPressOperator(at: 3)
        viewModel.didPressOperand(operand: 0)
        viewModel.didPressEqualButton(at: 4)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGiven3AddtionTo2DivideBy0WhendidPressEqualButtonThenAlertError() {
        let expectation = self.expectation(description: "Returned alert")
        
        viewModel.nextScreen = { screen in
            XCTAssertEqual(screen, .alert(title: "Alert", message: "Division par zéro impossible"))
            expectation.fulfill()
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 3)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 2)
        viewModel.didPressOperator(at: 3)
        viewModel.didPressOperand(operand: 0)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGiven3AdditionWhendidPressOperatorAgainThenAlertError() {
        let expectation = self.expectation(description: "Returned alert")
        
        viewModel.nextScreen = { screen in
            XCTAssertEqual(screen, .alert(title: "Alert", message: "Entrez un chiffre!"))
            expectation.fulfill()
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperator(at: 0)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGiven3Addition3WhendidPressEqualButtonAndAdd1ThenAlertError() {
        let expectation = self.expectation(description: "Returned alert")
        
        viewModel.nextScreen = { screen in
            XCTAssertEqual(screen, .alert(title: "Alert", message: "Entrez une expression correcte!"))
            expectation.fulfill()
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 3)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 3)
        viewModel.didPressEqualButton(at: 4)
        viewModel.didPressOperand(operand: 1)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}
