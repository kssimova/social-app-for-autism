//
//  ChildLoginViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 14.06.22.
//

import UIKit

class ChildLoginViewController: UIViewController {
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileTitleLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var wrongInputLabel: UILabel!
    @IBOutlet weak var buttonGradientView: DefaultGradientView!
    @IBOutlet weak var loginButtonView: UIView!
    
    @IBOutlet weak var loginButtonLabel: UILabel!
//
//    var backSelected : (() -> ()) = { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestures()
        setupUI()
    }
    
    private func setupGestures() {
        let loginGR = UITapGestureRecognizer(target: self, action: #selector(didTapLogin))
        loginButtonView.addGestureRecognizer(loginGR)
    }
    
    private func setupUI() {
        view.backgroundColor = .iceBlue
        
        loginView.backgroundColor = .white
        loginView.layer.cornerRadius = 16.0
        loginView.clipsToBounds = false
        
        profileImageView.image = UIImage(named: "bear")
        
        setupTextField(textField: usernameTextField, placeholder: "Потребителско име")
        setupTextField(textField: passwordTextField, placeholder: "Парола")
        
        loginButtonView.layer.cornerRadius = 16.0
        buttonGradientView.startColor = .lightRoyalBlue
        buttonGradientView.endColor = .purpley
        buttonGradientView.angle = 0
        buttonGradientView.clipsToBounds = true
        buttonGradientView.layer.cornerRadius = 16.0
        loginButtonLabel.text = "Влизане"
        loginButtonLabel.textColor = .white
        
        wrongInputLabel.handleWrongInput(text: nil)
    }
    
    private func setupTextField(textField: UITextField, placeholder: String) {
        textField.delegate = self
        textField.layer.cornerRadius = 16.0
        textField.clipsToBounds = true
        textField.backgroundColor = .veryLightGray
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkerLightGray])
    }
    
    @objc func didTapLogin() {
        print("#### Child login pressed...")
        if(usernameTextField.text?.isEmpty ?? true || passwordTextField.text?.isEmpty ?? true) {
            print("#### username or password empty..")
            wrongInputLabel.handleWrongInput(text: "Полетата не трябва да бъдат празни!")
        } else {
            DatabaseService.shared.login(email: usernameTextField.text!, password: passwordTextField.text!) { [weak self] auithResult in
                print("#### Completion block returned -> \(auithResult)")
                if let result = auithResult {
                    self?.wrongInputLabel.handleWrongInput(text: nil)
                } else {
                    self?.wrongInputLabel.handleWrongInput(text: "Грешно потребителско име или парола!")
                }
            }
        }
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension ChildLoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
