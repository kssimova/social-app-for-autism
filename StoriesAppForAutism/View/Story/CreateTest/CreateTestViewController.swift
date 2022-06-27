//
//  CreateTestViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 20.06.22.
//

import UIKit

class CreateTestViewController: UIViewController {
    @IBOutlet weak var testDetailsView: UIView!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var ageGroupLabel: UILabel!
    
    @IBOutlet weak var addQuestionButtonView: UIView!
    @IBOutlet weak var addQuestionGradientView: DefaultGradientView!
    @IBOutlet weak var addQuestionImageView: UIImageView!
    @IBOutlet weak var addQuestionButtonLabel: UILabel!
    
    @IBOutlet weak var allQuestionsLabel: UILabel!
    
    @IBOutlet weak var questionsTableView: UITableView!
    
    var viewModel: StoryDetailsViewModel!
    
    var addQuestionSelected : (() -> ()) = { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObservable()
        setupGestures()
        setupTableView()
        setupUI()
    }
    
    private func setupObservable() {
        viewModel.reloadQuestions = { [weak self] in
            print("#### Add new question selected, reloading data on main thread")
            DispatchQueue.main.async {
                self?.questionsTableView.reloadData()
            }
        }
    }
    
    private func setupGestures() {
        let addNewQuestionGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAddQuestionButton))
        addQuestionButtonView.addGestureRecognizer(addNewQuestionGesture)
    }
    
    private func setupTableView() {
        questionsTableView.registerCell(nibName: .CreateTestTableViewCell)
        questionsTableView.backgroundColor = .iceBlue
        questionsTableView.isScrollEnabled = true
        questionsTableView.delegate = self
        questionsTableView.dataSource = self
    }
    
    private func setupUI() {
        testDetailsView.backgroundColor = .white
        view.backgroundColor = .iceBlue
        
        testDetailsView.layer.cornerRadius = 16.0
        
        titleLabel.text = viewModel.baseStoryModel.title
        titleLabel.textColor = .black
        
        topicLabel.text = viewModel.baseStoryModel.topic
        topicLabel.textColor = .grayishBrown
        
        ageGroupLabel.text = viewModel.baseStoryModel.ageGroup
        ageGroupLabel.textColor = .indigoBlue
        
        allQuestionsLabel.text = "Всички въпроси"
        allQuestionsLabel.textColor = .black
        
        addQuestionButtonView.layer.cornerRadius = 16.0
        addQuestionGradientView.startColor = .lightRoyalBlue
        addQuestionGradientView.endColor = .purpley
        addQuestionGradientView.angle = 0
        addQuestionGradientView.clipsToBounds = true
        addQuestionGradientView.layer.cornerRadius = 16.0
        addQuestionButtonLabel.text = "Добави нов въпрос"
        addQuestionButtonLabel.textColor = .white
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapAddQuestionButton() {
        addQuestionSelected()
    }
}

extension CreateTestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.questionsDataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CreateTestTableViewCell.self), for: indexPath) as? CreateTestTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = viewModel.questionsDataSource[indexPath.row].description
        cell.questionImageView.image = viewModel.questionsDataSource[indexPath.row].image
        
        return cell
    }
}
