//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var screenTextView: UITextView!
    
    // MARK: - Properties
    
    private let viewModel = ViewModel()

    private lazy var alertView = UIAlertController()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: ViewModel) {
        viewModel.displayedText = { [weak self] text in
            self?.screenTextView.text = text
        }

        viewModel.nextScreen = { [weak self] screen in
            DispatchQueue.main.async {
                if case .alert(title: let title, message: let message) = screen {
                    self?.presentAlert(with: title, message: message)
                }
            }
        }
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        viewModel.didPressNumberButton(with: numberText)
    }
    
    @IBAction func tappedOperatorButtons(_ sender: UIButton) {
        let index = sender.tag
        viewModel.didSelectOperator(at: index)
        if sender.tag == 5 {
            viewModel.didPressEqualButton()
        }
    }

    
    @IBAction func tappedReturnButton(_ sender: Any) {
        viewModel.didPressReturnButton()
    }
    
    @IBAction func didPressClear(_ sender: Any) {
        viewModel.didPressClear()
    }

    // MARK: - Alert

    private func presentAlert(with title: String, message: String) {
        alertView.title = title
        alertView.message = message
        let okAction = UIAlertAction(title: "Zéro",
                                     style: .cancel,
                                     handler: nil)
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
}

