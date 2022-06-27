//
//  ListeningPhaseStepViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 22.06.22.
//

import UIKit

class ListeningPhaseStepViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionImageView: UIImageView!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var playButtonView: UIView!
    @IBOutlet weak var playButtonGradientView: DefaultGradientView!
    @IBOutlet weak var playButtonImageView: UIImageView!
    @IBOutlet weak var playButtonLabel: UILabel!
    
    @IBOutlet weak var nextStepButtonView: UIView!
    @IBOutlet weak var nextStepButtonImageView: UIImageView!
    @IBOutlet weak var nextStepButtonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .iceBlue
        
        headerView.backgroundColor = .white
        headerView.layer.cornerRadius = 16.0
        headerView.clipsToBounds = false
        
        headerImageView.image = UIImage(named: "listeningPhase")
        
        headerLabel.text = "Мария и нейната учителка"
        headerLabel.textColor = .black
        
        closeButton.setBackgroundImage(UIImage(named: "x")?.withRenderingMode(.alwaysTemplate), for: .normal)
        closeButton.tintColor = .black
        
        stepLabel.text = "Стъпка 1 от 4"
        stepLabel.textColor = .black
        
        questionLabel.text = "Мария и нейната учителка си говорят."
        questionLabel.textColor = .black
        
        questionView.backgroundColor = .white
        questionView.layer.cornerRadius = 16.0
        questionView.clipsToBounds = false
        
        playButtonView.layer.cornerRadius = 16.0
        playButtonGradientView.startColor = .lightRoyalBlue
        playButtonGradientView.endColor = .purpley
        playButtonGradientView.angle = 0
        playButtonGradientView.clipsToBounds = true
        playButtonGradientView.layer.cornerRadius = 16.0
        
        playButtonLabel.text = "Натисни, за да чуеш"
        playButtonLabel.textColor = .white
        playButtonImageView.image = UIImage(named: "volume")
        
        nextStepButtonView.layer.cornerRadius = 16.0
        nextStepButtonView.backgroundColor = .dullPink
        nextStepButtonImageView.image = UIImage(named: "arrowDropRightCircle")
        
        nextStepButtonLabel.text = "Следваща стъпка"
        nextStepButtonLabel.textColor = .white
        
        questionImageView.layer.cornerRadius = 16.0
    }
}
