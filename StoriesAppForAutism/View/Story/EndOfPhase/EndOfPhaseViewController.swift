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
    
    var viewModel: PhaseStepViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestures()
        setupUI()
    }
    
    private func setupGestures() {
        let nextStepGesture = UITapGestureRecognizer(target: self, action: #selector(didTapNextStepButton))
        nextStepButtonView.addGestureRecognizer(nextStepGesture)
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
        
        questionImageView.image = UIImage(named: "endReadingPhase")
        
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
        encouragementLabel.text = "Браво! \n Справи се чудесно с фазата за четене! Продължи напред с въпросите."
        
        questionImageView.layer.cornerRadius = 16.0
        
        nextStepButtonView.layer.cornerRadius = 16.0
        nextStepGradientView.startColor = .lightRoyalBlue
        nextStepGradientView.endColor = .purpley
        nextStepGradientView.angle = 0
        nextStepGradientView.clipsToBounds = true
        nextStepGradientView.layer.cornerRadius = 16.0
        nextStepButtonLabel.text = "Напред"
        nextStepButtonLabel.textColor = .white
        
        setStory()
    }
    
    func setStory() {
        DispatchQueue.main.async {
            switch self.viewModel.phase {
            case .listening:
                self.setEndOfListeningPhase()
            case .reading:
                self.setEndOfReadingPhase()
            default:
                self.setEndOfTestPhase()
            }
        }
    }
    
    private func setEndOfListeningPhase() {
        guard let story = viewModel.story else { return }

        headerImageView.image = UIImage(named: "listeningPhase")
        headerLabel.text = story.title
        questionImageView.image = UIImage(named: "endListeningPhase")
        tryAgainButtonView.isHidden = true
        correctAnswersLabel.isHidden = true
        encouragementLabel.text = "Браво! \n Справи се чудесно с фазата за слушане! Продължи напред към фазата за четене."
        nextStepButtonLabel.text = "Напред"
    }
    
    private func setEndOfReadingPhase() {
        guard let story = viewModel.story else { return }
        
        headerImageView.image = UIImage(named: "readingPhase")
        headerLabel.text = story.title
        questionImageView.image = UIImage(named: "endReadingPhase")
        tryAgainButtonView.isHidden = true
        correctAnswersLabel.isHidden = true
        encouragementLabel.text = "Браво! \n Справи се чудесно с фазата за четене! Продължи напред с въпросите."
        nextStepButtonLabel.text = "Напред"
    }
    
    private func setEndOfTestPhase() {
        guard let story = viewModel.story else { return }
        
        let isSuccessful = viewModel.correctAnswers == story.questions.count
        headerImageView.image = UIImage(named: "books")
        headerLabel.text = story.title
        questionImageView.image = UIImage(named: isSuccessful ? "endTestPhaseSuccessful" : "endTestPhaseNotSuccessful")
        tryAgainButtonView.isHidden = isSuccessful
        correctAnswersLabel.isHidden = false
        correctAnswersLabel.text = String(format: "%d/%d \n Правилни отговора", viewModel.correctAnswers, story.questions.count)
        encouragementLabel.text = isSuccessful ? "Браво! \n Справи се чудесно с въпросите! А сега опитай с нова история." : "Почти успя! \n Върни се на въпросите и опитай отново!"
        nextStepButtonLabel.text = "Виж други истории"
    }
    
    @objc func didTapNextStepButton() {
        viewModel.nextStepSelected()
    }
    
    deinit{
        print("#### Deinit called on EndOfPhaseVC")
    }

}
