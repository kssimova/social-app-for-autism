//
//  RegistrationViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 15.06.22.
//

import UIKit
import FirebaseDatabase

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var familyNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var roleTextField: UITextField!
    
    @IBOutlet weak var wrongInputLabel: UILabel!
    @IBOutlet weak var registerButtonView: UIView!
    @IBOutlet weak var registerGradientView: DefaultGradientView!
    @IBOutlet weak var registerButtonTitleLabel: UILabel!
    
    var viewModel: RegistrationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestures()
        setupUI()    
    }
    
    private func setupGestures() {
        let registerGR = UITapGestureRecognizer(target: self, action: #selector(didTapRegister))
        registerButtonView.addGestureRecognizer(registerGR)
    }
    
    private func setupUI() {
        view.backgroundColor = .iceBlue
        
        registerView.backgroundColor = .white
        registerView.layer.cornerRadius = 16.0
        registerView.clipsToBounds = false
        
        logoImageView.image = UIImage(named: "reverseCouple")
        
        wrongInputLabel.handleWrongInput(text: nil)
        
        setupDefaultTextField(textField: nameTextField, placeholder: "Име")
        setupDefaultTextField(textField: familyNameTextField, placeholder: "Фамилия")
        setupDefaultTextField(textField: usernameTextField, placeholder: "Потребителско име")
        setupDefaultTextField(textField: emailAddressTextField, placeholder: "Имейл адрес")
        setupDefaultTextField(textField: passwordTextField, placeholder: "Парола")
        setupDefaultTextField(textField: roleTextField, placeholder: "Роля")
        
        registerButtonView.layer.cornerRadius = 16.0
        registerGradientView.startColor = .lightRoyalBlue
        registerGradientView.endColor = .purpley
        registerGradientView.angle = 0
        registerGradientView.clipsToBounds = true
        registerGradientView.layer.cornerRadius = 16.0
        registerButtonTitleLabel.text = "Създаване на акаунт"
        registerButtonTitleLabel.textColor = .white
    }
    
    private func setupDefaultTextField(textField: UITextField, placeholder: String) {
        textField.layer.cornerRadius = 16.0
        textField.delegate = self
        textField.clipsToBounds = true
        textField.backgroundColor = .veryLightGray
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkerLightGray])
    }
    
    private func checkEmptyTextFields() {
        if nameTextField.text?.isEmpty ?? true
            || familyNameTextField.text?.isEmpty ?? true
            || usernameTextField.text?.isEmpty ?? true
            || emailAddressTextField.text?.isEmpty ?? true
            || passwordTextField.text?.isEmpty ?? true
            || roleTextField.text?.isEmpty ?? true {
            wrongInputLabel.handleWrongInput(text: "Полетата не трябва да бъдат празни!")
        } else {
            validateEmailAddress()
        }
    }
    
    private func validateEmailAddress() {
        if !isValidEmail(email: emailAddressTextField.text) {
            print("#### Email address not valid!")
            wrongInputLabel.handleWrongInput(text: "Имейл адресът не е валиден!")
        } else {
            checkPassword()
        }
    }
    
    private func checkPassword() {
        print("#### Checking passwords...")
        if passwordTextField.text?.count ?? 0 < 6 {
            wrongInputLabel.handleWrongInput(text: "Паролата трябва да е поне 6 символа!")
        } else {
            // API request to create profile
            registerUser()
        }
    }
    
    private func registerUser() {
        if let name = nameTextField.text,
           let familyName = familyNameTextField.text,
           let username = usernameTextField.text,
           let email = emailAddressTextField.text,
           let password = passwordTextField.text,
           let role = roleTextField.text {
            
            viewModel = RegistrationViewModel(user: User(name: name, familyName: familyName, email: email, username: username, userId: "", role: role), password: password)
            viewModel.register() { [weak self] isSuccessful, err in
                self?.handleRegistration(isSuccessful: isSuccessful, error: err)
            }
        }
    }
    
    private func handleRegistration(isSuccessful: Bool, error: Error?) {
        if isSuccessful {
            // Handle successful registration!\
            
        } else {
            if let error = error {
                wrongInputLabel.handleWrongInput(text: error.localizedDescription)
            }
        }
    }
    
    private func isValidEmail(email: String?) -> Bool {
        guard let emailAddress = email else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailAddress)
    }
    
    @objc func didTapRegister() {
        print("#### Tapped register")
        checkEmptyTextFields()
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension RegistrationViewController: UITextFieldDelegate {
    
}
