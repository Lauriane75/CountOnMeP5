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
    
    func testGiven1Addition2WhenDidPressEqualButtonThenElementAtIndex5Is3() {
        
        // operator is +
        viewModel.didSelectOperator(at: 0)
        viewModel.didPressNumberButton(with: "1")
        
    }


}
