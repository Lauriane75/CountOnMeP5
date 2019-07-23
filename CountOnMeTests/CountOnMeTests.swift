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
    
    var viewModel: ViewModel!
    override func setUp() {
        
        super.setUp()
        viewModel = ViewModel()
    }
    
    // viewModel.viewDidLoad() => displayedText("1 + 2 = 3")
    func testGivenAViewModelWhenViewDidLoadThenDisplayedTextIsCorrctlyReturned() {
        let expectation = self.expectation(description: "Returned text")
        viewModel.displayedText = { text in
            
            XCTAssertEqual(text, "1 + 2 = 3")
            
            expectation.fulfill()
        }
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    // viewModel.didPressNumberButton(with: "2") => "2"
    func testGivenAViewModelWhenDidPressNumberButtonThenDisplayedTextIsCorrctlyReturned() {
        let expectation = self.expectation(description: "Returned text")
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 1 {
                XCTAssertEqual(text, "2")
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        viewModel.didPressNumberButton(with: "2")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    // viewModel.didSelectOperator(at: 0) => +
    func testGivenAViewModelWhenDidSelectOperatorIsMultiplyThenDisplayedTextIsCorrctlyReturned() {
        let expectation = self.expectation(description: "Returned text")
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 1 {
                XCTAssertEqual(text, "+")
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        viewModel.didSelectOperator(at: 0)
        waitForExpectations(timeout: 1.0, handler: nil)
        
    }
    
    // viewModel.didSelectOperator(at: 4) => =
    func testGivenAViewModelWhenDidSelectOperatorIsEqualThenDisplayedTextIsCorrctlyReturned() {
        let expectation = self.expectation(description: "Returned text")
        
        var counter = 0
        
        viewModel.displayedText = { text in
            if counter == 1 {
                XCTAssertEqual(text, "=")
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        viewModel.didSelectOperator(at: 4)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    // left / right / operand / result
    func testGivenDidNumberButtonIs2Substraction3WhenDidPressEqualButtonThenLeftIs2RightIs30perandIsPlusAndResultIs5() {
        
        let expectation = self.expectation(description: "Returned text")
        var counter = 0
        
        viewModel.displayedText = { text in
            
            if counter == 3 {
                XCTAssertEqual(text, "3 - 2")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressNumberButton(with: "3")
        viewModel.didSelectOperator(at: 1)
        viewModel.didPressNumberButton(with: "2")
        waitForExpectations(timeout: 1.0, handler: nil)
        
        viewModel.displayedText = { text in
            
            if counter == 1 {
                XCTAssertEqual(text, "3 - 2 = ")
                XCTAssertEqual(self.viewModel.left, 3)
                XCTAssertEqual(self.viewModel.operand, "-")
                XCTAssertEqual(self.viewModel.right, 2)
                XCTAssertEqual(self.viewModel.result, 1)
                expectation.fulfill()
            }
            counter += 1
        }
        self.viewModel.didPressEqualButton()
    }

    // viewModel.didPressReturnButton()
    func testGivenDidPressNumberButtonIs23WhenDidPressReturnButtonThenTextIsReturning2() {

        let expectation = self.expectation(description: "Returned text")
        var counter = 0
        
        viewModel.displayedText = { text in
            
            if counter == 2 {
                XCTAssertEqual(text, "23")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressNumberButton(with: "2")
        viewModel.didPressNumberButton(with: "3")
        waitForExpectations(timeout: 1.0, handler: nil)
        
        viewModel.displayedText = { text in
            
            if counter == 1 {
                XCTAssertEqual(text, "2")
                expectation.fulfill()
            }
            counter += 1
        }
        
        self.viewModel.didPressReturnButton()
    }
    
    // viewModel.didPressReturnButton() = viewModel.displayedText => viewModel.stringElement
    func testGivenDidPressNumberButtonIs23WhenDidPressReturnButtonThenDisplayedTextIsStringElement() {
        
        let expectation = self.expectation(description: "Returned text")
        var counter = 0
        
        viewModel.displayedText = { text in
            
            if counter == 2 {
                XCTAssertEqual(text, "23")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressNumberButton(with: "2")
        viewModel.didPressNumberButton(with: "3")
        waitForExpectations(timeout: 1.0, handler: nil)
        
        viewModel.displayedText = { text in
            
            if counter == 1 {
                XCTAssertEqual(text, self.viewModel.stringElement)
                expectation.fulfill()
            }
            counter += 1
        }
        
        self.viewModel.didPressReturnButton()
    }
    
    // viewModel.didPressClear()
    func testGivenDidPressNumberButtonIs5WhenDidPressclearButtonThenDisplayedTextIsCorrctlyCleared() {
        
        let expectation = self.expectation(description: "Returned text")
        var counter = 0
        
        viewModel.displayedText = { text in
            
            if counter == 1 {
                XCTAssertEqual(text, "5")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressNumberButton(with: "5")
        waitForExpectations(timeout: 1.0, handler: nil)
    
        viewModel.displayedText = { text in
            
            if counter == 1 {
                XCTAssertEqual(text, "")
                expectation.fulfill()
            }
            counter += 1
        }
        
        self.viewModel.didPressClear()
    }
    
    // viewModel.displayedText => viewModel.stringElement
    func testGivenViewDidLoadWhenDidPressNumberButtonThenDisplayedTextIsStringElement() {
        
        let expectation = self.expectation(description: "Returned text")
        var counter = 0
        
        viewModel.displayedText = { text in
            
            if counter == 1 {
                XCTAssertEqual(text, "5")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressNumberButton(with: "5")
        waitForExpectations(timeout: 1.0, handler: nil)
        
        viewModel.displayedText = { text in
            
            if counter == 1 {
                XCTAssertEqual(text, self.viewModel.stringElement)
                expectation.fulfill()
            }
            counter += 1
        }
    }
    
    
//    func testGivenDidPressSelectOperatorIsxWhenDidPressEqualButtonThenEnumIsMultiplication() {
//        
//        let expectation = self.expectation(description: "Returned text")
//        var counter = 0
//        
//        viewModel.displayedText = { text in
//            
//            if counter == 3 {
//                XCTAssertEqual(text, "5 x 2")
//                expectation.fulfill()
//            }
//            counter += 1
//        }
//        viewModel.viewDidLoad()
//        viewModel.didPressNumberButton(with: "5")
//        viewModel.didSelectOperator(at: 2)
//        viewModel.didPressNumberButton(with: "2")
//        waitForExpectations(timeout: 1.0, handler: nil)
//        
//        viewModel.displayedText = { text in
//            
//            if counter == 1 {
//                XCTAssert()
//                expectation.fulfill()
//            }
//            counter += 1
//        }
//        self.viewModel.didPressEqualButton()
//    }
    
    // addition
    func testGivenOneAndTwoWhenDidPressSelectAdditionThenResultIs3() {
        let expectation = self.expectation(description: "Returned text")
        var counter = 0
        
        viewModel.displayedText = { text in
            
            if counter == 3 {
                XCTAssertEqual(text, "1 + 2")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressNumberButton(with: "1")
        viewModel.didSelectOperator(at: 0)
        viewModel.didPressNumberButton(with: "2")
        waitForExpectations(timeout: 1.0, handler: nil)
        
        viewModel.displayedText = { text in
            
            if counter == 1 {
                XCTAssertEqual(self.viewModel.left, 1)
                XCTAssertEqual(self.viewModel.operand, "+")
                XCTAssertEqual(self.viewModel.right, 2)
                XCTAssertEqual(self.viewModel.result, 3)
                expectation.fulfill()
            }
            counter += 1
        }
        self.viewModel.didPressEqualButton()
    }
    
    // substraction
    func testGivenTwoAndOneWhenDidPressSelectSubstractionThenResultIs1() {
        viewModel.didPressNumberButton(with: "2")
        viewModel.didSelectOperator(at: 1)
        viewModel.didPressNumberButton(with: "1")
        
        viewModel.didPressEqualButton()
        
        XCTAssertEqual(viewModel.result, 1)
    }
    
    // multiplication
    func testGivenTwoAndFourWhenDidPressSelectMultiplicationThenResultIs8() {
        viewModel.didPressNumberButton(with: "2")
        viewModel.didSelectOperator(at: 2)
        viewModel.didPressNumberButton(with: "4")
        
        viewModel.didPressEqualButton()
        
        XCTAssertEqual(viewModel.result, 8)
    }
    
    // division
    func testGivenFourAndTwoWhenDidPressSelectDivisionThenResultIs2() {
        viewModel.didPressNumberButton(with: "4")
        viewModel.didSelectOperator(at: 3)
        viewModel.didPressNumberButton(with: "2")
    
        viewModel.didPressEqualButton()
        
        XCTAssertEqual(viewModel.result, 2)
    }
    
    // viewModel.timesEqualButtonTapped = []
    func testGivenARandomOperationWhenDidEqualButtonThentimesEqualButtonTappedIsEmpty() {
        viewModel.didPressNumberButton(with: "4")
        viewModel.didSelectOperator(at: 3)
        viewModel.didPressNumberButton(with: "2")
        
        viewModel.didPressEqualButton()
        
        XCTAssertEqual(viewModel.timesEqualButtonTapped, [])
    }
    
    // viewModel.timesEqualButtonTapped = [2]
    func testGivenARandomOperationWhenDidPressEqualButtonAgainThenTimesEqualButtonIs2() {
        
        let expectation = self.expectation(description: "Returned text")
        var counter = 0
        
        viewModel.displayedText = { text in
            
            if counter == 4 {
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        viewModel.didPressNumberButton(with: "1")
        viewModel.didSelectOperator(at: 0)
        viewModel.didPressNumberButton(with: "2")
        viewModel.didPressEqualButton()
        waitForExpectations(timeout: 1.0, handler: nil)
        
        viewModel.displayedText = { text in
            if counter == 1 {
                XCTAssertEqual(self.viewModel.timesEqualButtonTapped, [2])
                expectation.fulfill()
                
            }
            counter += 1
        }
        self.viewModel.didPressNumberButton(with: "2")
       
        self.viewModel.didPressEqualButton()
    }
    
    // viewModel.expressionHaveResult = true
    func testGivenARandomNumberWhenDidPressNumberButtonThenExpressionHaveResultIsTrue() {
        
        let expectation = self.expectation(description: "Returned text")
        var counter = 0
        
        viewModel.displayedText = { text in
            
            if counter == 2 {
                
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressNumberButton(with: "1")
        viewModel.didPressNumberButton(with: "2")
        waitForExpectations(timeout: 1.0, handler: nil)
        
        viewModel.displayedText = { text in
            if counter == 1 {
                XCTAssertTrue(self.viewModel.expressionHaveResult)
                expectation.fulfill()
            }
            counter += 1
        }
    }
    
    // viewModel.expressionHaveResult = false
    func testGivenARandomNumberWhenDidPressNumberButtonThenExpressionHaveResultIsFalse() {
        
        let expectation = self.expectation(description: "Returned text")
        var counter = 0
        
        viewModel.displayedText = { text in
            if counter == 1 {
                
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didSelectOperator(at: 4)
        viewModel.didPressEqualButton()
    
        waitForExpectations(timeout: 1.0, handler: nil)
        viewModel.displayedText = { text in
            if counter == 1 {
                XCTAssertFalse(self.viewModel.expressionHaveResult)
                expectation.fulfill()
            }
            counter += 1
        }
    }
    
    // viewModel.expressionHaveEnoughElement = true
    func testGivenARandomOperationWhenDidPressEqualButtonThenExpressionHaveEnoughElementIsTrue() {

        let expectation = self.expectation(description: "Returned text")
        var counter = 0

        viewModel.displayedText = { text in

            if counter == 4 {
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressNumberButton(with: "1")
        viewModel.didSelectOperator(at: 0)
        viewModel.didPressNumberButton(with: "2")
        viewModel.didPressEqualButton()
        waitForExpectations(timeout: 1.0, handler: nil)

        viewModel.displayedText = { text in
            if counter == 1 {
                XCTAssertTrue(self.viewModel.expressionHaveEnoughElement)
                expectation.fulfill()
            }
            counter += 1
        }
        self.viewModel.didPressEqualButton()
    }
    
    // viewModel.expressionHaveEnoughElement = false
    func testGivenARandomOperationWhenDidPressEqualButtonThenExpressionHaveEnoughElementIsFalse() {
        
        let expectation = self.expectation(description: "Returned text")
        var counter = 0
        
        viewModel.displayedText = { text in
            
            if counter == 4 {
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressNumberButton(with: "1")
        viewModel.didSelectOperator(at: 0)
        viewModel.didPressNumberButton(with: "1")
        viewModel.didPressEqualButton()
        viewModel.didPressNumberButton(with: "1")
        waitForExpectations(timeout: 1.0, handler: nil)
        
        viewModel.displayedText = { text in
            if counter == 1 {
                XCTAssertFalse(self.viewModel.expressionHaveEnoughElement)
                expectation.fulfill()
            }
            counter += 1
        }
        self.viewModel.didPressEqualButton()
    }
    
    // viewModel.lastElementIsNotAnOperator = true
    func testGivenViewDidLoadWhenDidPressNumberButtonThenlastElementIsNotAnOperatorIsTrue() {
        
        let expectation = self.expectation(description: "Returned text")
        var counter = 0
        
        viewModel.displayedText = { text in
            
            if counter == 1 {
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressNumberButton(with: "1")
        waitForExpectations(timeout: 1.0, handler: nil)
        
        viewModel.displayedText = { text in
            if counter == 1 {
                XCTAssertTrue(self.viewModel.lastElementIsNotAnOperator)
                expectation.fulfill()
            }
            counter += 1
        }
    }
    
    // viewModel.lastElementIsNotAnOperator = false
    func testGivenViewDidLoadWhenDidPressNumberButtonThenlastElementIsNotAnOperatorIsFalse() {
        
        let expectation = self.expectation(description: "Returned text")
        var counter = 0
        
        viewModel.displayedText = { text in
            
            if counter == 2 {
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressNumberButton(with: "1")
        viewModel.didSelectOperator(at: 0)
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        viewModel.displayedText = { text in
            if counter == 1 {
                XCTAssertFalse(self.viewModel.lastElementIsNotAnOperator)
                expectation.fulfill()
            }
            counter += 1
        }
    }
    
    // viewModel.firstElementIsAnOperator = true
    func testGivenViewDidLoadWhenDidSelectOperatorButtonThenFirstElementIsAnOperatorIsTrue() {
        
        let expectation = self.expectation(description: "Returned text")
        var counter = 0
        
        viewModel.displayedText = { text in
            
            if counter == 1 {
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didSelectOperator(at: 0)
        waitForExpectations(timeout: 1.0, handler: nil)
        
        viewModel.displayedText = { text in
            if counter == 1 {
                XCTAssertTrue(self.viewModel.firstElementIsAnOperator)
                expectation.fulfill()
            }
            counter += 1
        }
    }
    
    // viewModel.firstElementIsAnOperator = false
    func testNumberButtonIs1WhenDidSelectOperatorButtonThenFirstElementIsAnOperatorIsFalse() {
        
        let expectation = self.expectation(description: "Returned text")
        var counter = 0
        
        viewModel.displayedText = { text in
            
            if counter == 2 {
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressNumberButton(with: "1")
        viewModel.didSelectOperator(at: 0)
        waitForExpectations(timeout: 1.0, handler: nil)
        
        viewModel.displayedText = { text in
            if counter == 1 {
                XCTAssertFalse(self.viewModel.firstElementIsAnOperator)
                expectation.fulfill()
            }
            counter += 1
        }
    }
    
    
    
} // End
