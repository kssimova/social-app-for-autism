//
//  Story.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 26.06.22.
//

import UIKit
import FirebaseDatabase

class Story: Codable {
    var title: String
    var description: String
    var topic: String
    var difficultyLevel: String
    var ageGroup: String
    var coverImageURL: String
    var pages: [Page]
    var questions: [Question]
    
    init(userDict: [String: Any]) {
        self.title = userDict["title"] as! String
        self.description = userDict["description"] as! String
        self.topic = userDict["topic"] as! String
        self.difficultyLevel = userDict["difficultyLevel"] as! String
        self.ageGroup = userDict["ageGroup"] as! String
        self.coverImageURL = userDict["coverImageURL"] as! String
        self.pages = [Page]()
        self.questions = [Question]()
        
        if let pages = userDict["pages"] as? [Any] {
            for page in pages {
                if let dict = page as? [String:Any] {
                    let pg = Page(value: dict)
                    self.pages.append(pg)
                }
            }
        }
        
        if let questions = userDict["questions"] as? [Any] {
            for question in questions {
                if let dict = question as? [String:Any] {
                    let q = Question(value: dict)
                    self.questions.append(q)
                }
            }
        }
    }
}
