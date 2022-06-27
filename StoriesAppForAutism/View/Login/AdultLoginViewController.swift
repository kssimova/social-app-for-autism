//
//  AdultLoginViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 15.06.22.
//

import UIKit

class AdultLoginViewController: UIViewController {
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileTitleLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var wrongInputLabel: UILabel!
    @IBOutlet weak var loginButtonView: UIView!
    @IBOutlet weak var loginButtonLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var buttonGradientView: DefaultGradientView!
    @IBOutlet weak var registerButton: UIButton!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupGestures()
    }
    
    private func setupUI() {
        view.backgroundColor = .iceBlue
        
        loginView.backgroundColor = .white
        loginView.layer.cornerRadius = 16.0
        loginView.clipsToBounds = false
        
        profileImageView.image = UIImage(named: "reverseCouple")
        
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
        
        wrongInputLabel.textColor = .blue
        wrongInputLabel.isHidden = true
        
        orLabel.text = "Или"
        orLabel.textColor = .black
        
        registerButton.backgroundColor = UIColor.dullPink
        registerButton.layer.cornerRadius = 16.0
        registerButton.setTitle("Създаване на акаунт", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.setTitleColor(.white, for: .selected)
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLoginButton))
        loginButtonView.addGestureRecognizer(tapGesture)
    }
    
    private func setupTextField(textField: UITextField, placeholder: String) {
        textField.delegate = self
        textField.layer.cornerRadius = 14.0
        textField.clipsToBounds = true
        textField.backgroundColor = .veryLightGray
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkerLightGray])
    }
    
    @objc func didTapLoginButton() {
        if(usernameTextField.text?.isEmpty ?? true || passwordTextField.text?.isEmpty ?? true) {
            wrongInputLabel.handleWrongInput(text: "Полетата не трябва да бъдат празни!")
        } else {
            viewModel.setupProperties(email: usernameTextField.text, password: passwordTextField.text)
            handleValidData()
        }
    }
    
    private func handleValidData() {
        viewModel.login {  [weak self] isSuccessul in
            if isSuccessul {
                self?.wrongInputLabel.handleWrongInput(text: nil)
            } else {
                self?.wrongInputLabel.handleWrongInput(text: "Грешно потребителско име или парола!")
            }
        }
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapRegisterButton(_ sender: UIButton) {
        viewModel.registerSelected()
    }
    
}

extension AdultLoginViewController: UITextFieldDelegate {
    
}
