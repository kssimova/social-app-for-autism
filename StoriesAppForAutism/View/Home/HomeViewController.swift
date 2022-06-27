//
//  HomeViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 16.06.22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var childrenProfilesView: UIView!
    @IBOutlet weak var childrenProfilesImageView: UIImageView!
    @IBOutlet weak var childrenProfilesGradientView: DefaultGradientView!
    @IBOutlet weak var childrenProfilesLabel: UILabel!
    
    @IBOutlet weak var libraryView: UIView!
    @IBOutlet weak var libraryGradientView: DefaultGradientView!
    @IBOutlet weak var libraryImageView: UIImageView!
    @IBOutlet weak var libraryLabel: UILabel!
    
    var childProfilesSelected : (() -> ()) = { }
    var librarySelected : (() -> ()) = { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestures()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .iceBlue

        childrenProfilesView.backgroundColor = .white
        childrenProfilesView.layer.cornerRadius = 16.0
        childrenProfilesView.clipsToBounds = false
        childrenProfilesGradientView.startColor = .lightRoyalBlue
        childrenProfilesGradientView.endColor = .purpley
        childrenProfilesGradientView.angle = 0
        childrenProfilesGradientView.clipsToBounds = true
        childrenProfilesGradientView.layer.cornerRadius = 16.0
        childrenProfilesLabel.text = "Детски профили"
        childrenProfilesLabel.textColor = .white
        
        libraryView.backgroundColor = .white
        libraryView.layer.cornerRadius = 16.0
        libraryView.clipsToBounds = false
        libraryGradientView.startColor = .barbiePink
        libraryGradientView.endColor = .cornflowerBlue
        libraryGradientView.angle = 0
        libraryGradientView.clipsToBounds = true
        libraryGradientView.layer.cornerRadius = 16.0
        libraryLabel.text = "Библиотека с истории"
        libraryLabel.textColor = .white
    }
    
    private func setupGestures() {
        let childLoginGR = UITapGestureRecognizer(target: self, action: #selector(didSelectChildProfiles))
        childrenProfilesView.addGestureRecognizer(childLoginGR)
        
        let adultLoginGR = UITapGestureRecognizer(target: self, action: #selector(didSelectLibrary))
        libraryView.addGestureRecognizer(adultLoginGR)
    }
    
    @objc func didSelectChildProfiles() {
        childProfilesSelected()
    }
    
    @objc func didSelectLibrary() {
        librarySelected()
    }
}
