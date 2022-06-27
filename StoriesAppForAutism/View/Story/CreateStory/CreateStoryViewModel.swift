//
//  CreateStoryViewModel.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 24.06.22.
//

import UIKit

class CreateStoryViewModel {
    let difficulyLevelDataSource = ["Лесно", "Средно", "Трудно", "Много трудно"]
    let topicDataSource = ["Хигиена", "Емоции", "Събития", "Училище", "Вкъщи", "Друга"]
    let ageGroupDataSource = ["0-4", "5-10", "11-15", "16+"]
    
    var createStorySelected : (() -> ()) = { }
    var baseStoryModel: BaseStoryModel?
}
