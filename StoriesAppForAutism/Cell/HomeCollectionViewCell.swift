//
//  HomeCollectionViewCell.swift
//  SocialApp
//
//  Created by Kristina Simova on 21.05.22.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var scenarioTitleLabel: UILabel!
    @IBOutlet weak var scenarioDifficultyLevelLabel: UILabel!
    
    func setUp() {
        setBaseCell()
    }
    
    private func setBaseCell(){
        layer.cornerRadius = 16.0
        layer.borderWidth = 1
        layer.borderColor = UIColor.blue.cgColor
        layer.backgroundColor = UIColor.systemBlue.cgColor
    }
}
