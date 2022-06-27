//
//  StoryLibraryTableViewCell.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 17.06.22.
//

import UIKit

class StoryLibraryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var storyView: UIView!
    @IBOutlet weak var storyImageView: UIImageView!
    @IBOutlet weak var storyTitleLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var ageGroupLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .iceBlue
        storyView.backgroundColor = .white
        storyView.layer.cornerRadius = 16.0
        storyView.clipsToBounds = false
        
        storyTitleLabel.textColor = .black
        topicLabel.textColor = .grayishBrown
        ageGroupLabel.textColor = .indigoBlue
    }
}
