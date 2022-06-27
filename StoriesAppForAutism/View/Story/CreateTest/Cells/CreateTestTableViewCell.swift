//
//  CreateTestTableViewCell.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 20.06.22.
//

import UIKit

class CreateTestTableViewCell: UITableViewCell {
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
//    var viewModel: CreateTestViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .iceBlue
        questionView.backgroundColor = .white
        questionView.layer.cornerRadius = 16.0
        questionView.clipsToBounds = false
        
        titleLabel.textColor = .black
    }
}
