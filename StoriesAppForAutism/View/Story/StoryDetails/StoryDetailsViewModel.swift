//
//  StoryDetailsViewModel.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 25.06.22.
//

import UIKit

class StoryDetailsViewModel {
    var baseStoryModel: BaseStoryModel
    var pagesDataSource: [Page]
    var questionsDataSource: [Question]
    
    var reloadPages : (() -> ()) = { }
    var reloadQuestions : (() -> ()) = { }

    init(baseStoryModel: BaseStoryModel, pagesDataSource: [Page], questionsDataSource: [Question]) {
        self.baseStoryModel = baseStoryModel
        self.pagesDataSource = pagesDataSource
        self.questionsDataSource = questionsDataSource
    }
    
    func saveStory() {
        uploadAudioFiles()
        uploadCoverImage()
        uploadPagesImages()
        uploadQuestionsImages()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let bsModel = self?.baseStoryModel, let pages = self?.pagesDataSource, let questions = self?.questionsDataSource else {
                return
            }
            
            DatabaseService.shared.createStory(baseStoryModel: bsModel, pages: pages, questions: questions) {_ in
                
            }
        }
    }
    
    private func uploadAudioFiles() {
        StorageService.shared.uploadAudioFiles(pages: pagesDataSource) { [weak self] isSuccessful, url in
            guard let url = url else { return }
            

        }
    }
    
    
    private func uploadCoverImage() {
        guard let coverImage = baseStoryModel.coverImage else { return }

        StorageService.shared.uploadImage(folder: "coverImages", image: coverImage) { [weak self] isSuccessful, url in
            print("#### uploadCoverImage isSuccessful -> \(isSuccessful) ")
            if let url = url {
                print("#### Completion handler returned, URL is not nil -> \(url)")
                self?.baseStoryModel.coverImageURL = url
            }
        }
    }
    
    private func uploadPagesImages() {
        for page in pagesDataSource {
            StorageService.shared.uploadImage(folder: "pages", image: page.image) { [weak self] isSuccessful, url in
                if let url = url {
                    page.imageDownloadURL = url
                }
            }
        }
    }
    
    private func uploadQuestionsImages() {
        for question in questionsDataSource {
            StorageService.shared.uploadImage(folder: "questions", image: question.image) { [weak self] isSuccessful, url in
                print("#### uploadQuestionsImages isSuccessful -> \(isSuccessful) ")
                if let url = url {
                    print("#### Completion handler returned, URL is not nil -> \(url)")

                    question.imageDownloadURL = url
                }
            }
        }
        
        
    }
}
