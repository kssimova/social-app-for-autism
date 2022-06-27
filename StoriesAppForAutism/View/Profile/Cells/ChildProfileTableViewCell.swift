//
//  ChildProfileTableViewCell.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 16.06.22.
//

import UIKit

class ChildProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var childImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dotsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .iceBlue
        profileView.backgroundColor = .white
        profileView.layer.cornerRadius = 16.0
        profileView.clipsToBounds = false
        
        nameLabel.textColor = .black
        usernameLabel.textColor = .brownishGrey
        
//        childImageView.layer.cornerRadius = 16.0
        
//        successfulRegistrationView.backgroundColor = .white
//        successfulRegistrationView.layer.cornerRadius = 16.0
//        successfulRegistrationView.clipsToBounds = false
//
//        descriptionLabel.text = "Please note, that upon registration an \n email will be sent which has to be \n opened on the device itself to \n continue with the registration \n process.\n\n  If you forget your password, a reset \n password email will be sent to this \n email address."
//
//        continueButtonView.layer.cornerRadius = 16.0
//        continueGradientView.startColor = .lightRoyalBlue
//        continueGradientView.endColor = .purpley
//        continueGradientView.angle = 0
//        continueGradientView.clipsToBounds = true
//        continueGradientView.layer.cornerRadius = 16.0
//        continueButtonLabel.text = "Продължи"
//        continueButtonLabel.textColor = .white
    }
}
