//
//  ChildrenProfilesViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 16.06.22.
//

import UIKit

class ChildrenProfilesViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addChildProfileButtonView: UIView!
    @IBOutlet weak var addChildProfileGradientView: DefaultGradientView!
    @IBOutlet weak var addChildProfileButtonLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profilesTableView: UITableView!
    
    var createChildProfileSelected : (() -> ()) = { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestures()
        setupTableView()
        setupUI()
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCreateChildProfie))
        addChildProfileButtonView.addGestureRecognizer(tapGesture)
    }
    
    private func setupTableView() {
        profilesTableView.registerCell(nibName: .ChildProfileTableViewCell)
        profilesTableView.backgroundColor = .iceBlue
        profilesTableView.isScrollEnabled = true
        profilesTableView.delegate = self
        profilesTableView.dataSource = self
    }
    
    private func setupUI() {
        view.backgroundColor = .iceBlue
        titleLabel.textColor = .black
        titleLabel.text = "Детски профили"
        
        addChildProfileButtonView.layer.cornerRadius = 16.0
        addChildProfileGradientView.startColor = .lightRoyalBlue
        addChildProfileGradientView.endColor = .purpley
        addChildProfileGradientView.angle = 0
        addChildProfileGradientView.clipsToBounds = true
        addChildProfileGradientView.layer.cornerRadius = 16.0
        addChildProfileButtonLabel.text = "Добави нов профил на дете"
        addChildProfileButtonLabel.textColor = .white
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapCreateChildProfie() {
        createChildProfileSelected()
    }
    let names = ["Ivan Kolev", "Simona Georgieva"]
    let usernames = ["vanko10", "barbie"]
}

extension ChildrenProfilesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChildProfileTableViewCell.self), for: indexPath) as? ChildProfileTableViewCell else {
            return UITableViewCell()
        }
        
        cell.childImageView.image = UIImage(named: String(format: "child%d", Int.random(in: 1..<8)))
        cell.nameLabel.text = names[indexPath.row]
        cell.usernameLabel.text = usernames[indexPath.row]
        
        return cell
    }
    
    
}
