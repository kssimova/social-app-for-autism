//
//  StoryLibraryViewModel.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 26.06.22.
//

import UIKit
import FirebaseDatabase

class StoryLibraryViewModel {
    var snapshot: StoriesSnapshot?
    var reloadData : (() -> Void) = { }
    
    func subscribe() {
        DatabaseService.shared.storiesReference.observe(DataEventType.value) { snapshot in
            self.snapshot = StoriesSnapshot(with: snapshot)
            self.reloadData()
        }
    }
}
