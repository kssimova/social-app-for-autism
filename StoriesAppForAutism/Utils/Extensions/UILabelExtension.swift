//
//  UILabelExtension.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 19.06.22.
//

import UIKit

extension UILabel {
    func handleWrongInput(text: String?) {
        self.isHidden = text == nil
        self.text = text
        self.textColor = .red
    }
}
