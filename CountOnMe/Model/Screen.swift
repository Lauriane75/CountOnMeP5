//
//  Screen.swift
//  CountOnMe
//
//  Created by Lauriane Haydari on 23/07/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

enum Screen {
    case alert(title: String, message: String)
}

final class ScreenView {
    
      private lazy var alertView = UIAlertController()
    
    // MARK: - Alert
    
    private func presentAlert(with title: String, message: String) {
        alertView.title = title
        alertView.message = message
        let okAction = UIAlertAction(title: "OK",
                                     style: .cancel,
                                     handler: nil)
        alertView.addAction(okAction)
        //present(alertView, animated: true, completion: nil)
    }
} // end



//
//enum AlertType: Equatable {
//    case operationError
//}
//
//struct Alert: Equatable {
//    let title: String
//    let message: String
//}
//
//extension Alert {
//    init(type: AlertType) {
//        switch type {
//        case .operationError:
//            self = Alert(title: "Alert", message: "A very very bad thing happened.. 🙈")
//        }
//    }
//}
