//
//  CreateProfileViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 16.06.22.
//

import UIKit

class CreateProfileViewController: UIViewController {
    @IBOutlet weak var createProfileView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var addProfileImageLabel: UILabel!
    
    @IBOutlet weak var nameTextField: InsetTextField!
    @IBOutlet weak var familyNameTextField: InsetTextField!
    @IBOutlet weak var genderTextField: InsetTextField!
    @IBOutlet weak var ageTextField: InsetTextField!
    @IBOutlet weak var usernameTextField: InsetTextField!
    @IBOutlet weak var passwordTextField: InsetTextField!
    
    @IBOutlet weak var wrongInputLabel: UILabel!
    @IBOutlet weak var createProfileButtonView: UIView!
    @IBOutlet weak var createProfileGradientView: DefaultGradientView!
    @IBOutlet weak var createProfileButtonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .iceBlue
        
        createProfileView.backgroundColor = .white
        createProfileView.layer.cornerRadius = 16.0
        createProfileView.clipsToBounds = false
        
        uploadImageView.image = UIImage(named: "uploadPhoto")
        
        addProfileImageLabel.text = "Добавяне на профилна снимка"
        addProfileImageLabel.textColor = .black
        
        nameTextField.layer.cornerRadius = 16.0
        nameTextField.clipsToBounds = true
        nameTextField.backgroundColor = .veryLightGray
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Име", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkerLightGray])
        
        familyNameTextField.layer.cornerRadius = 16.0
        familyNameTextField.clipsToBounds = true
        familyNameTextField.backgroundColor = .veryLightGray
        familyNameTextField.attributedPlaceholder = NSAttributedString(string: "Фамилия", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkerLightGray])
        
        genderTextField.layer.cornerRadius = 16.0
        genderTextField.clipsToBounds = true
        genderTextField.backgroundColor = .veryLightGray
        genderTextField.attributedPlaceholder = NSAttributedString(string: "Пол", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkerLightGray])
        
        ageTextField.layer.cornerRadius = 16.0
        ageTextField.clipsToBounds = true
        ageTextField.backgroundColor = .veryLightGray
        ageTextField.attributedPlaceholder = NSAttributedString(string: "Възраст", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkerLightGray])
        
        usernameTextField.layer.cornerRadius = 16.0
        usernameTextField.clipsToBounds = true
        usernameTextField.backgroundColor = .veryLightGray
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Потребителско име", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkerLightGray])
        
        passwordTextField.layer.cornerRadius = 16.0
        passwordTextField.clipsToBounds = true
        passwordTextField.backgroundColor = .veryLightGray
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Парола", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkerLightGray])
        
        
        createProfileButtonView.layer.cornerRadius = 16.0
        createProfileGradientView.startColor = .lightRoyalBlue
        createProfileGradientView.endColor = .purpley
        createProfileGradientView.angle = 0
        createProfileGradientView.clipsToBounds = true
        createProfileGradientView.layer.cornerRadius = 16.0
        createProfileButtonLabel.text = "Създаване на профил на дете"
        createProfileButtonLabel.textColor = .white
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
