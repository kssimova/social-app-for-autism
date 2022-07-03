//
//  TestPhaseStepViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 21.06.22.
//

import UIKit

class TestPhaseStepViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var stepLabel: UILabel!
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var firstAnswerButton: UIButton!
    @IBOutlet weak var secondAnswerButton: UIButton!
    @IBOutlet weak var thirdAnswerButton: UIButton!
    @IBOutlet weak var fourthAnswerButton: UIButton!
    
    var viewModel: PhaseStepViewModel!
    
    var number: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        guard let story = viewModel.story else { return }
        
        view.backgroundColor = .iceBlue
        
        headerView.backgroundColor = .white
        headerView.layer.cornerRadius = 16.0
        headerView.clipsToBounds = false
        
        headerImageView.image = UIImage(named: "questionPopup")
        
        headerLabel.text = viewModel.story?.title
        headerLabel.textColor = .black
        
        closeButton.setBackgroundImage(UIImage(named: "x")?.withRenderingMode(.alwaysTemplate), for: .normal)
        closeButton.tintColor = .black
        
        stepLabel.text = String(format: "Въпрос %d от %d", viewModel.step, story.questions.count)
        stepLabel.textColor = .black
        
        questionLabel.text = story.questions[viewModel.step - 1].description
        questionLabel.textColor = .black
        
        setupButton(button: firstAnswerButton, title: story.questions[viewModel.step - 1].answers[0], tag: 1)
        setupButton(button: secondAnswerButton, title: story.questions[viewModel.step - 1].answers[1], tag: 2)
        setupButton(button: thirdAnswerButton, title: story.questions[viewModel.step - 1].answers[2], tag: 3)
        setupButton(button: fourthAnswerButton, title: story.questions[viewModel.step - 1].answers[3], tag: 4)
        
        questionView.backgroundColor = .white
        questionView.layer.cornerRadius = 16.0
        questionView.clipsToBounds = false
        
        questionImageView.layer.cornerRadius = 16.0
        
        number = getNumber(string: story.questions[viewModel.step - 1].correctAnswer)
    }
    
    private func setupButton(button: UIButton, title: String, tag: Int) {
        button.backgroundColor = .purpleyTwo
        button.tintColor = .white
        button.tag = tag
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16.0
        button.clipsToBounds = false
    }
    
    private func checkCorrectAnswer(button: UIButton) {
        if button.tag == number {
            button.backgroundColor = .apple
            viewModel.correctAnswers += 1
        } else {
            button.backgroundColor = .coral
            if let tmpButton = self.view.viewWithTag(number) as? UIButton {
                tmpButton.backgroundColor = .apple
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.viewModel.nextStepSelected()
        }
    }
    
    private func getNumber(string: String) -> Int {
        if let number = Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
            return number
        }
        
        return 1
    }

    @IBAction func didTapFirstButton(_ sender: UIButton) {
        checkCorrectAnswer(button: sender)
    }
    
    @IBAction func didTapSecondButton(_ sender: UIButton) {
        checkCorrectAnswer(button: sender)
    }
    
    @IBAction func didTapThirdButton(_ sender: UIButton) {
        checkCorrectAnswer(button: sender)
    }
    
    @IBAction func didTapFourthButton(_ sender: UIButton) {
        checkCorrectAnswer(button: sender)
    }
    
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        viewModel.closeSelected()
    }
    
}
