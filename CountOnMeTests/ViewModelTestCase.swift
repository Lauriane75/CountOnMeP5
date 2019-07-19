//
//  SimpleCalcUITests.swift
//  SimpleCalcUITests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest

@testable import CountOnMe

class ViewModelTestCase: XCTestCase {
    
     var viewModel: ViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ViewModel()
    }
    
    func testGivenLeftIs1AndRightIs2_WhenOperandIsPlus_ThenResultIs3() {
        viewModel.left = 1
        viewModel.right = 2
        viewModel.operand = " + "
//        
//
//        XCTAssertTrue(viewModel.result = "3")
    }
    
}
