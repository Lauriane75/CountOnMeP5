//
//  Screen.swift
//  CountOnMe
//
//  Created by Lauriane Haydari on 23/07/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

final class Alert {


    // MARK: - Alert

     func presentAlert(on vcl: UIViewController, with title: String, message: String) {
        let alertView = UIAlertController(title: title ,message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertView.addAction(okAction)
        vcl.present(alertView, animated: true, completion: nil)
    }
    
    
} // end














//final class Alert {
//
//    private lazy var alertView = UIAlertController()
//
//    // MARK: - Alert
//
//    private func presentAlert(vcl: UIAlertController, with title: String, message: String) {
//        alertView.title = title
//        alertView.message = message
//        let okAction = UIAlertAction(title: "OK",
//                                     style: .cancel,
//                                     handler: nil)
//        alertView.addAction(okAction)
//        //present(alertView, animated: true, completion: nil)
//    }
//} // end




