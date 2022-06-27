//
//  Question.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 25.06.22.
//

import UIKit

class Question: Codable {
    var description: String
    var image: UIImage?
    var answers: [String]
    var correctAnswer: String
    var imageDownloadURL: URL?
    
    init(description: String, image: UIImage, answers: [String], correctAnswer: String) {
        self.description = description
        self.image = image
        self.answers = answers
        self.correctAnswer = correctAnswer
    }
    
    init(value: [String: Any]) {
        self.description = value["description"] as! String
        self.answers = value["answers"] as! [String]
        self.imageDownloadURL = URL(string: value["imageDownloadURL"] as! String)
        self.correctAnswer = value["correctAnswer"] as! String
    }
    
    private enum CodingKeys: String, CodingKey {
        case description, answers, correctAnswer, imageDownloadURL
    }
}
