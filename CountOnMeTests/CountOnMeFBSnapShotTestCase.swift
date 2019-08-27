//
//  CountOnMeFBSnapShotTestCase.swift
//  CountOnMeTests
//
//  Created by Lauriane Haydari on 26/08/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import FBSnapshotTestCase
@testable import CountOnMe

class CountOnMeFBSnapShotTestCase: FBSnapshotTestCase {

    // swiftlint:disable force_cast
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
        as! ViewController

    override func setUp() {
        super.setUp()
        recordMode = true
    }

func testWelcomeView_WithName() {
    viewController.screenTextView.text = "0"
    FBSnapshotVerifyView(viewController.view)
    FBSnapshotVerifyLayer(viewController.view.layer)
    }
}
