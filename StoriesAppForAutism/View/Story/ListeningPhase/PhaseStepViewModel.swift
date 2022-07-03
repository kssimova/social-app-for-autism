//
//  PhaseStepViewModel.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 2.07.22.
//

import Foundation

enum Phase {
    case listening, reading, test
}

class PhaseStepViewModel {
    weak var story: Story?
    var phase: Phase
    var step: Int
    var correctAnswers: Int = 0
    
    var nextStepSelected : (() -> Void) = { }
    var closeSelected : (() -> Void) = { }
    
    init(story: Story, phase: Phase, step: Int, correctAnswers: Int = 0) {
        self.story = story
        self.phase = phase
        self.step = step
        self.correctAnswers = correctAnswers
    }
}
