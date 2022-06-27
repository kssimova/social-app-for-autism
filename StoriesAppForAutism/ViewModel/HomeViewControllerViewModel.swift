//
//  HomeViewControllerViewModel.swift
//  SocialApp
//
//  Created by Kristina Simova on 21.05.22.
//

import Foundation

struct HomeViewControllerViewModel {
    var title: String
    
    var storySelected : (() -> ()) = { }
}
