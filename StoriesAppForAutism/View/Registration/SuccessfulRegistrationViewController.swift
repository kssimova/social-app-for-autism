//
//  SuccessfulRegistrationViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 15.06.22.
//

import UIKit

class SuccessfulRegistrationViewController: UIViewController {
    
    @IBOutlet weak var successfulRegistrationView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var continueButtonView: UIView!
    @IBOutlet weak var continueGradientView: DefaultGradientView!
    @IBOutlet weak var continueButtonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .iceBlue

        successfulRegistrationView.backgroundColor = .white
        successfulRegistrationView.layer.cornerRadius = 16.0
        successfulRegistrationView.clipsToBounds = false
        
        descriptionLabel.text = "Please note, that upon registration an \n email will be sent which has to be \n opened on the device itself to \n continue with the registration \n process.\n\n  If you forget your password, a reset \n password email will be sent to this \n email address."
        
        continueButtonView.layer.cornerRadius = 16.0
        continueGradientView.startColor = .lightRoyalBlue
        continueGradientView.endColor = .purpley
        continueGradientView.angle = 0
        continueGradientView.clipsToBounds = true
        continueGradientView.layer.cornerRadius = 16.0
        continueButtonLabel.text = "Продължи"
        continueButtonLabel.textColor = .white
    }
}
