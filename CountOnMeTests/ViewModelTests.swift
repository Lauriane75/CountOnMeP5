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

    func testGivenAViewModelWhenViewDidLoadThenDisplayedTextIsCorrctlyReturned() {
        let viewModel = ViewModel()
        let expectation = self.expectation(description: "Returned text")

        viewModel.displayedText = { text in
            XCTAssertEqual(text, "1 + 2 = 3")
            expectation.fulfill()
        }

        viewModel.viewDidLoad()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGivenAViewModelWhenDidPressNumberButtonThenDisplayedTextIsCorrctlyReturned() {
        let viewModel = ViewModel()
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

}
