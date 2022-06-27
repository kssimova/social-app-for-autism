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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .iceBlue
        
        headerView.backgroundColor = .white
        headerView.layer.cornerRadius = 16.0
        headerView.clipsToBounds = false
        
        headerImageView.image = UIImage(named: "questionPopup")
        
        headerLabel.text = "Мария и нейната учителка"
        headerLabel.textColor = .black
        
        closeButton.setBackgroundImage(UIImage(named: "x")?.withRenderingMode(.alwaysTemplate), for: .normal)
        closeButton.tintColor = .black
        
        stepLabel.text = "Въпрос 2 от 3"
        stepLabel.textColor = .black
        
        questionLabel.text = "Какво правиха в историята Мария и нейната учителка"
        questionLabel.textColor = .black
        
        setupButton(button: firstAnswerButton, title: "Говориха си")
        setupButton(button: secondAnswerButton, title: "Хапваха")
        setupButton(button: thirdAnswerButton, title: "Рисуваха")
        setupButton(button: fourthAnswerButton, title: "Спяха")
        
        firstAnswerButton.backgroundColor = .apple
        
        questionView.backgroundColor = .white
        questionView.layer.cornerRadius = 16.0
        questionView.clipsToBounds = false
        
        questionImageView.layer.cornerRadius = 16.0
    }
    
    private func setupButton(button: UIButton, title: String) {
        button.backgroundColor = .purpleyTwo
        button.tintColor = .white
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16.0
        button.clipsToBounds = false
    }
    
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        
    }
    
}
