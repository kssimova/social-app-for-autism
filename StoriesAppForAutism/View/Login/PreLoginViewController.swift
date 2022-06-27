//
//  PreLoginViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 13.06.22.
//

import UIKit

class PreLoginViewController: UIViewController {
    @IBOutlet weak var childProfileView: UIView!
    @IBOutlet weak var childProfileTitleLabel: UILabel!
    @IBOutlet weak var childProfileDescriptionLabel: UILabel!
    @IBOutlet weak var childProfileImageView: UIImageView!
    @IBOutlet weak var childGradientView: DefaultGradientView!
    
    @IBOutlet weak var adultProfileView: UIView!
    @IBOutlet weak var adultProfileTitleLabel: UILabel!
    @IBOutlet weak var adultProfileDescriptionLabel: UILabel!
    @IBOutlet weak var adultProfileImageView: UIImageView!
    @IBOutlet weak var adultGradientView: DefaultGradientView!
    
    var loginSelected : ((Bool) -> ()) = { _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupGestures()
    }
    
    private func setupUI() {
        view.backgroundColor = .iceBlue
        
        childProfileView.layer.cornerRadius = 16.0
        childGradientView.clipsToBounds = true
        childGradientView.layer.cornerRadius = 16.0
        childGradientView.startColor = .lightRoyalBlue
        childGradientView.endColor = .purpley
        childProfileTitleLabel.textColor = .white
        childProfileDescriptionLabel.textColor = .white
        
        adultProfileView.layer.cornerRadius = 16.0
        adultGradientView.clipsToBounds = true
        adultGradientView.layer.cornerRadius = 16.0
        adultGradientView.startColor = .barbiePink
        adultGradientView.endColor = .cornflowerBlue
        adultProfileTitleLabel.textColor = .white
        adultProfileDescriptionLabel.textColor = .white
    }
    
    private func setupGestures() {
        let childLoginGR = UITapGestureRecognizer(target: self, action: #selector(didSelectChildLogin))
        childProfileView.addGestureRecognizer(childLoginGR)
        
        let adultLoginGR = UITapGestureRecognizer(target: self, action: #selector(didSelectAdultLogin))
        adultProfileView.addGestureRecognizer(adultLoginGR)
    }
    
    @objc func didSelectChildLogin() {
        loginSelected(false)
    }
    
    @objc func didSelectAdultLogin() {
        loginSelected(true)
    }
}
