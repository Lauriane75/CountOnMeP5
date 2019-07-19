//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // outlet
    @IBOutlet weak var screenView: UITextView!
    
    // MARK: - Properties
    private let viewModel = ViewModel()

    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: ViewModel) {
        viewModel.displayedText = { text in
            self.screenView.text = text
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
        //        } else {
        //            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
        //            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        //            self.present(alertVC, animated: true, completion: nil)
        //        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        viewModel.didPressEqualButton()
        //        guard viewModel.expressionIsCorrect else {
        //            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
        //            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        //            return self.present(alertVC, animated: true, completion: nil)
        //        }
        //
        //        guard viewModel.expressionHaveEnoughElement else {
        //            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
        //            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        //            return self.present(alertVC, animated: true, completion: nil)
        //        }
        //
    }
    @IBAction func tappedReturnButton(_ sender: Any) {
        viewModel.didPressReturnButton()
    }
    
    @IBAction func tappedRemoveButton(_ sender: Any) {
        viewModel.didPressRemoveButton()
    }
} // end

