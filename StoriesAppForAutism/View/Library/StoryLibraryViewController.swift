//
//  StoryLibraryViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 17.06.22.
//

import UIKit
import FirebaseDatabase

class StoryLibraryViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var createNewStoryStackView: UIStackView!
    @IBOutlet weak var createNewStoryButtonView: UIView!
    @IBOutlet weak var createStoryGradientView: DefaultGradientView!
    @IBOutlet weak var createNewStoryButtonLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var storiesTableView: UITableView!
    
    var createNewStorySelected : (() -> ()) = { }
    let viewModel = StoryLibraryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObservable()
        setupGestures()
        setupTableView()
        setupUI()
    }
    
    private func setupObservable() {
        viewModel.subscribe()
        
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.storiesTableView.reloadData()
            }
        }
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCreateNewStoryButton))
        createNewStoryButtonView.addGestureRecognizer(tapGesture)
    }
    
    private func setupTableView() {
        createNewStoryButtonView.isHidden = false
        storiesTableView.registerCell(nibName: .StoryLibraryTableViewCell)
        storiesTableView.backgroundColor = .iceBlue
        storiesTableView.isScrollEnabled = true
        storiesTableView.delegate = self
        storiesTableView.dataSource = self
    }
    
    private func setupUI() {
        view.backgroundColor = .iceBlue
        titleLabel.textColor = .black
        titleLabel.text = "Всички истории"
        
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.layer.cornerRadius = 16.0
        searchBar.searchTextField.clipsToBounds = true
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Търсене...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkerLightGray])
        searchBar.layer.cornerRadius = 16.0
        
        createNewStoryButtonView.layer.cornerRadius = 16.0
        createStoryGradientView.startColor = .lightRoyalBlue
        createStoryGradientView.endColor = .purpley
        createStoryGradientView.angle = 0
        createStoryGradientView.clipsToBounds = true
        createStoryGradientView.layer.cornerRadius = 16.0
        createNewStoryButtonLabel.text = "Създай нова история"
        createNewStoryButtonLabel.textColor = .white
    }
    
    @objc func didTapCreateNewStoryButton() {
        createNewStorySelected()
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapCreateChildProfie() {
        
    }
    
}

extension StoryLibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.snapshot?.stories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StoryLibraryTableViewCell.self), for: indexPath) as? StoryLibraryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.storyTitleLabel.text = viewModel.snapshot?.stories[indexPath.row].title
        cell.storyTitleLabel.textColor = .black
        cell.topicLabel.text = viewModel.snapshot?.stories[indexPath.row].topic
        cell.ageGroupLabel.text = viewModel.snapshot?.stories[indexPath.row].ageGroup
        
        return cell
    }
    
}
