//
//  BaseStoryModel.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 25.06.22.
//

import UIKit

class BaseStoryModel: Codable {
    var coverImage: UIImage?
    var title: String?
    var description: String?
    var difficultyLevel: String?
    var topic: String?
    var ageGroup: String?
    var coverImageURL: URL?
    
    init(coverImage: UIImage?, title: String?, description: String?, difficultyLevel: String?, topic: String?, ageGroup: String?) {
        self.coverImage = coverImage
        self.title = title
        self.description = description
        self.difficultyLevel = difficultyLevel
        self.topic = topic
        self.ageGroup = ageGroup
    }
    
    private enum CodingKeys: String, CodingKey {
        case title, description, difficultyLevel, topic, ageGroup, coverImageURL
    }
}
