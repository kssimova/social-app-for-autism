//
//  Page.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 25.06.22.
//

import UIKit

class Page: Codable {
    var audioUUID: String
    var description: String
    var image: UIImage?
    var audioData: Data?
    var imageDownloadURL: URL?
    var audioDownloadURL: URL?
    
    init(description: String, image: UIImage, audioData: Data, audioUUID: String) {
        self.description = description
        self.image = image
        self.audioData = audioData
        self.audioUUID = audioUUID
    }
    
    init(value: [String: Any]) {
        self.description = value["description"] as! String
        self.audioUUID = value["audioUUID"] as! String
        self.imageDownloadURL = URL(string: value["imageDownloadURL"] as! String)
        self.audioDownloadURL = URL(string: value["audioDownloadURL"] as! String)
    }
    
    private enum CodingKeys: String, CodingKey {
        case audioUUID, description, imageDownloadURL, audioDownloadURL
    }
}
