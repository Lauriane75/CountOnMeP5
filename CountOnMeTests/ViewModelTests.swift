//
//  ViewModel.swift
//  CountOnMe
//
//  Created by Lauriane Haydari on 17/07/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

@testable import CountOnMe
import XCTest

final class ViewModelTests: XCTestCase {
    
    var viewModel: ViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ViewModel()
    }

    func testGivenAViewModelWhenViewDidLoadThenDisplayedTextIsCorrctlyReturned() {
        let expectation = self.expectation(description: "Returned text")

        viewModel.displayedText = { text in
            XCTAssertEqual(text, "1 + 2 = 3")
            expectation.fulfill()
        }

        viewModel.viewDidLoad()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

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
    
    func testGivenOneAndTwoWhenDidPressSelectAdditionThenResultIs3() {
//        let viewModel = ViewModel()
//        let expectation = self.expectation(description: "Returned text")
//
//        var counter = 0
//        viewModel.displayedText = { text in
//            if counter == 5 {
//                XCTAssertEqual(text, "1+2=3")
//                expectation.fulfill()
//            }
//             counter += 1
//        }
        viewModel.didPressNumberButton(with: "1")
        viewModel.didSelectOperator(at: 0)
        viewModel.didPressNumberButton(with: "2")
        
        viewModel.didPressEqualButton()
        
        XCTAssertEqual(viewModel.result, 3)
//        waitForExpectations(timeout: 1.0, handler: nil)
        
    }
    
    func testGivenTwoAndOneWhenDidPressSelectSubstractionThenResultIs1() {
        
        viewModel.didPressNumberButton(with: "2")
        viewModel.didSelectOperator(at: 1)
        viewModel.didPressNumberButton(with: "1")
        
        viewModel.didPressEqualButton()
        
        XCTAssertEqual(viewModel.result, 1)
    }
    
    func testGivenTwoAndFourWhenDidPressSelectMultiplicationThenResultIs8() {
        
        viewModel.didPressNumberButton(with: "2")
        viewModel.didSelectOperator(at: 2)
        viewModel.didPressNumberButton(with: "4")
        
        viewModel.didPressEqualButton()
        
        XCTAssertEqual(viewModel.result, 8)
    }
    
    func testGivenFourAndTwoWhenDidPressSelectDivisionThenResultIs2() {
        
        viewModel.didPressNumberButton(with: "4")
        viewModel.didSelectOperator(at: 3)
        viewModel.didPressNumberButton(with: "2")
        
        viewModel.didPressEqualButton()
        
        XCTAssertEqual(viewModel.result, 2)
    }
    


} // End
