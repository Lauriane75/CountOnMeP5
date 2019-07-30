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
    
    private let viewModel = CalculatorViewModel()

    private lazy var alertView = UIAlertController()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: CalculatorViewModel) {
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
        guard let operandText = sender.title(for: .normal) else {
            return
        }
            viewModel.didPressOperand(operand: Int(operandText)!)
       
    }
    
    @IBAction func tappedOperatorButtons(_ sender: UIButton) {
            viewModel.didPressOperator(at: sender.tag)
    }

    @IBAction func tappedDeleteButton(_ sender: Any) {
        viewModel.didPressDelete()
    }
    
    @IBAction func didPressClear(_ sender: Any) {
        viewModel.didPressClear()
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
            viewModel.didPressEqualButton(at: sender.tag)
    }
    
    // MARK: - Alert

    private func presentAlert(with title: String, message: String) {
        alertView.title = title
        alertView.message = message
        let okAction = UIAlertAction(title: "OK",
                                     style: .cancel,
                                     handler: nil)
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
   
}

