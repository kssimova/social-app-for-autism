//
//  EndOfPhaseViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 22.06.22.
//

import UIKit

class EndOfPhaseViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionImageView: UIImageView!
    
    @IBOutlet weak var correctAnswersLabel: UILabel!
    @IBOutlet weak var encouragementLabel: UILabel!
    
    @IBOutlet weak var tryAgainButtonView: UIView!
    @IBOutlet weak var tryAgainButtonLabel: UILabel!
    
    @IBOutlet weak var nextStepButtonView: UIView!
    @IBOutlet weak var nextStepGradientView: DefaultGradientView!
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
        
        headerImageView.image = UIImage(named: "readingPhase")
        
        headerLabel.text = "Мария и нейната учителка"
        headerLabel.textColor = .black
        
        closeButton.setBackgroundImage(UIImage(named: "x")?.withRenderingMode(.alwaysTemplate), for: .normal)
        closeButton.tintColor = .black
        
        questionView.backgroundColor = .white
        questionView.layer.cornerRadius = 16.0
        questionView.clipsToBounds = false
        
        questionImageView.image = UIImage(named: "endReadingPhase")//endTestPhaseSuccessful") //endTestPhaseNotSuccessful
        
        tryAgainButtonView.layer.cornerRadius = 16.0
        tryAgainButtonView.backgroundColor = .dullPink
        tryAgainButtonLabel.text = "Опитай пак"
        tryAgainButtonLabel.textColor = .white
        tryAgainButtonView.isHidden = true
        
        nextStepButtonLabel.text = "Следваща стъпка"
        nextStepButtonLabel.textColor = .white
        
        correctAnswersLabel.isHidden = true
        correctAnswersLabel.text = "2/5 \n Правилни отговора"
        correctAnswersLabel.textColor = .black
        encouragementLabel.textColor = .black
        encouragementLabel.text = "Браво! \n Справи се чудесно с фазата за четене! Продължи напред с въпросите."//"Почти успя! \n Върни се на въпросите и опитай отново!"//"Браво! \n Справи се чудесно с въпросите! А сега опитай с нова история"//"Браво! \n Справи се чудесно с фазата за четене! Продължи напред с въпросите" //"Браво! \n Справи се чудесно с фазата за слушане! Продължи напред към фазата за четене."
        
        questionImageView.layer.cornerRadius = 16.0
        
        nextStepButtonView.layer.cornerRadius = 16.0
        nextStepGradientView.startColor = .lightRoyalBlue
        nextStepGradientView.endColor = .purpley
        nextStepGradientView.angle = 0
        nextStepGradientView.clipsToBounds = true
        nextStepGradientView.layer.cornerRadius = 16.0
        nextStepButtonLabel.text = "Напред" //"Виж други истории"
        nextStepButtonLabel.textColor = .white
    }

}
