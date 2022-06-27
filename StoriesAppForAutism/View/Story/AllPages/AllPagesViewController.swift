//
//  AllPagesViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 25.06.22.
//

import UIKit

class AllPagesViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var addNewPageButtonView: UIView!
    @IBOutlet weak var addNewPageGradientView: DefaultGradientView!
    @IBOutlet weak var addNewPageButtonLabel: UILabel!
    
    @IBOutlet weak var allStoriesLabel: UILabel!
    @IBOutlet weak var pagesTableView: UITableView!
    
    var viewModel: StoryDetailsViewModel!
    
    var addNewPageSelected : (() -> ()) = { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObservable()
        setupGestures()
        setupTableView()
        setupUI()
    }
    
    private func setupObservable() {
        viewModel.reloadPages = { [weak self] in
            print("#### Add new page selected, reloading data on main thread")
            DispatchQueue.main.async {
                self?.pagesTableView.reloadData()
            }
        }
    }
    
    private func setupGestures() {
        let addNewPageGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAddNewPage))
        addNewPageButtonView.addGestureRecognizer(addNewPageGesture)
    }
    
    private func setupTableView() {
        pagesTableView.registerCell(nibName: .CreateTestTableViewCell)
        pagesTableView.backgroundColor = .iceBlue
        pagesTableView.isScrollEnabled = true
        pagesTableView.delegate = self
        pagesTableView.dataSource = self
    }
    
    private func setupUI() {
        view.backgroundColor = .iceBlue
        
        allStoriesLabel.textColor = .black
        allStoriesLabel.text = "Всички страници"

        addNewPageButtonView.layer.cornerRadius = 16.0
        addNewPageGradientView.startColor = .lightRoyalBlue
        addNewPageGradientView.endColor = .purpley
        addNewPageGradientView.angle = 0
        addNewPageGradientView.clipsToBounds = true
        addNewPageGradientView.layer.cornerRadius = 16.0
        addNewPageButtonLabel.text = "Създаване на нова страница"
        addNewPageButtonLabel.textColor = .white
    }
    
    
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapAddNewPage() {
        addNewPageSelected()
    }
    
}

extension AllPagesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pagesDataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CreateTestTableViewCell.self), for: indexPath) as? CreateTestTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = viewModel.pagesDataSource[indexPath.row].description
        cell.questionImageView.image = viewModel.pagesDataSource[indexPath.row].image
        
        return cell
    }
    
}
