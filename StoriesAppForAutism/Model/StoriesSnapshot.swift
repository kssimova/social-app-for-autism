//
//  StoriesSnapshot.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 26.06.22.
//

import Foundation
import FirebaseDatabase

struct StoriesSnapshot {
    let stories: [Story]
    
    init?(with snapshot: DataSnapshot) {
        var stories = [Story]()
        
        guard let snapshotDictionary = snapshot.value as? [String : [String : Any]] else { return nil }
        
        for dictionary in snapshotDictionary {
            if let snap = dictionary.value as? [String : Any] {
                let story = Story(userDict: snap)
                stories.append(story)
            }
            
        }
        
        self.stories = stories
    }
}
