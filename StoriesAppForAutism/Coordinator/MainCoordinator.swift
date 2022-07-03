//
//  MainCoordinator.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 17.06.22.
//

import UIKit

extension MainCoordinator: Coordinator { }
class MainCoordinator {
    var children = [Coordinator]()
    
    private var rootController = PreLoginViewController()
    
    private var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
    
    func start() -> UIViewController {
        navigationController.setViewControllers([rootController], animated: false)
        
        rootController.loginSelected = { [weak self] isAdultLoginSelected in
            print("#### Login selected, adult -> \(isAdultLoginSelected)")
            self?.showLoginController(isAdultLoginSelected: isAdultLoginSelected)
        }
        
        return navigationController
    }
    
    func showLoginController(isAdultLoginSelected: Bool) {
        print("#### Showing login controller")
        if isAdultLoginSelected {
            self.showAdultLoginVC()
        } else {
            self.showChildLoginVC()
        }
    }
    
    func showAdultLoginVC() {
        let loginVC = AdultLoginViewController()
        
        loginVC.viewModel.registerSelected = { [weak self] in
            print("#### Regiter button selected")
            self?.showRegistrationVC()
        }
        
        loginVC.viewModel.loginFinished = { [weak self] in
            print("#### Login finished in MAIN COORDINATOR, showing home")
            self?.showHomeVC()
        }
        
        self.navigationController.pushViewController(loginVC, animated: true)
    }
    
    func showChildLoginVC() {
        let loginVC = ChildLoginViewController()
        
        loginVC.viewModel.loginFinished = { [weak self] in
            print("#### Login finished in MAIN COORDINATOR, child login showing home")
            self?.showLibraryVC(isFromChildProfile: true)
        }
        
        self.navigationController.pushViewController(loginVC, animated: true)
    }
    
    func showRegistrationVC() {
        let registerVC = RegistrationViewController()
        self.navigationController.pushViewController(registerVC, animated: true)
    }
    
    func showHomeVC() {
        let homeVC = HomeViewController()
        
        homeVC.childProfilesSelected = { [weak self] in
            self?.showChildProfilesVC()
        }
        
        homeVC.librarySelected = { [weak self] in
            self?.showLibraryVC(isFromChildProfile: false)
        }
        
        navigationController.setViewControllers([homeVC], animated: true)
    }
    
    func showChildProfilesVC() {
        let childProfilesVC = ChildrenProfilesViewController()
        
        childProfilesVC.createChildProfileSelected = { [weak self] in
            self?.showCreateChildProfileVC()
        }
        
        navigationController.pushViewController(childProfilesVC, animated: true)
    }
    
    func showCreateChildProfileVC() {
        let createChildProfileVC = CreateProfileViewController()
        navigationController.pushViewController(createChildProfileVC, animated: true)
    }
    
    func showLibraryVC(isFromChildProfile: Bool) {
        let libraryVC = StoryLibraryViewController()
        libraryVC.viewModel = StoryLibraryViewModel(isFromChildProfile: isFromChildProfile)
        
        libraryVC.viewModel.createNewStorySelected = { [weak self] in
            self?.showCreateNewStoryVC()
        }
        
        libraryVC.viewModel.storySelected = { [weak self] story in
            self?.showListeningPhaseVC(story: story, phase: .listening, step: 1)
        }
        
        navigationController.pushViewController(libraryVC, animated: true)
    }
    
    func showListeningPhaseVC(story: Story, phase: Phase, step: Int) {
        let listeningPhaseVC = ListeningPhaseStepViewController()
        listeningPhaseVC.viewModel = PhaseStepViewModel(story: story, phase: .listening, step: step)
        
        listeningPhaseVC.viewModel.nextStepSelected = { [weak self, unowned listeningPhaseVC] in
            if let story = listeningPhaseVC.viewModel.story, listeningPhaseVC.viewModel.step == story.pages.count{
                self?.showEndOfListeningPhaseVC(story: story, phase: .reading)
            } else {
                self?.showListeningPhaseVC(story: story, phase: .listening, step: (step + 1))
            }
            
            listeningPhaseVC.viewModel.story = nil
        }
        
        listeningPhaseVC.viewModel.closeSelected = { [weak self] in
            self?.popToLibraryVC()
        }
        
        navigationController.pushViewController(listeningPhaseVC, animated: true)
    }
    
    func showEndOfListeningPhaseVC(story: Story, phase: Phase) {
        let endOfListeningPhaseVC = EndOfPhaseViewController()
        endOfListeningPhaseVC.viewModel = PhaseStepViewModel(story: story, phase: .listening, step: 1)
        
        endOfListeningPhaseVC.viewModel.nextStepSelected = { [weak self, unowned endOfListeningPhaseVC] in
            if let story = endOfListeningPhaseVC.viewModel.story {
                self?.showReadingPhaseVC(story: story, phase: .reading, step: 1)
            }
            
            endOfListeningPhaseVC.viewModel.story = nil
        }
        
        navigationController.pushViewController(endOfListeningPhaseVC, animated: true)
    }
    
    func showReadingPhaseVC(story: Story, phase: Phase, step: Int) {
        let readingPhaseVC = ReadingPhaseStepViewController()
        readingPhaseVC.viewModel = PhaseStepViewModel(story: story, phase: .reading, step: step)
        
        readingPhaseVC.viewModel.nextStepSelected = { [weak self, unowned readingPhaseVC] in
            if let story = readingPhaseVC.viewModel.story, readingPhaseVC.viewModel.step == story.pages.count {
                self?.showEndOfReadingPhaseVC(story: story, phase: .reading, step: 1)
            } else {
                self?.showReadingPhaseVC(story: story, phase: .reading, step: (step + 1))
            }
            
            readingPhaseVC.viewModel.story = nil
        }
        
        readingPhaseVC.viewModel.closeSelected = { [weak self] in
            self?.popToLibraryVC()
        }
        
        navigationController.pushViewController(readingPhaseVC, animated: true)
    }
    
    func showEndOfReadingPhaseVC(story: Story, phase: Phase, step: Int) {
        let endOfReadingPhaseVC = EndOfPhaseViewController()
        endOfReadingPhaseVC.viewModel = PhaseStepViewModel(story: story, phase: .reading, step: 1)
        
        endOfReadingPhaseVC.viewModel.nextStepSelected = { [weak self, unowned endOfReadingPhaseVC] in
            if let story = endOfReadingPhaseVC.viewModel.story {
                self?.showTestPhaseVC(story: story, phase: .reading, step: 1, correctAnswers: 0)
            }
            
            endOfReadingPhaseVC.viewModel.story = nil
        }
        
        navigationController.pushViewController(endOfReadingPhaseVC, animated: true)
    }
    
    func showTestPhaseVC(story: Story, phase: Phase, step: Int, correctAnswers: Int) {
        let testPhaseVC = TestPhaseStepViewController()
        testPhaseVC.viewModel = PhaseStepViewModel(story: story, phase: .test, step: step, correctAnswers: correctAnswers)
         
        testPhaseVC.viewModel.nextStepSelected = { [weak self, unowned testPhaseVC] in
            if let story = testPhaseVC.viewModel.story {
                if testPhaseVC.viewModel.step == story.questions.count {
                    self?.showEndOfTestPhaseVC(story: story, phase: .test, correctAnswers: testPhaseVC.viewModel.correctAnswers)
                } else {
                    self?.showTestPhaseVC(story: story, phase: .test, step: (step + 1), correctAnswers: testPhaseVC.viewModel.correctAnswers)
                }
            }
            
            testPhaseVC.viewModel.story = nil
        }
        
        testPhaseVC.viewModel.closeSelected = { [weak self] in
            self?.popToLibraryVC()
        }
        
        navigationController.pushViewController(testPhaseVC, animated: true)
    }
    
    func showEndOfTestPhaseVC(story: Story, phase: Phase, correctAnswers: Int) {
        let endOfTestPhaseVC = EndOfPhaseViewController()
        endOfTestPhaseVC.viewModel = PhaseStepViewModel(story: story, phase: .test, step: 1, correctAnswers: correctAnswers)
        
        endOfTestPhaseVC.viewModel.nextStepSelected = { [weak self, unowned endOfTestPhaseVC] in
            self?.popToLibraryVC()
            endOfTestPhaseVC.viewModel.story = nil
        }
        
        navigationController.pushViewController(endOfTestPhaseVC, animated: true)
    }
    
    func popToLibraryVC() {
        for controller in navigationController.viewControllers as Array {
            if controller.isKind(of: StoryLibraryViewController.self) {
                self.navigationController.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    func showCreateNewStoryVC() {
        let createNewStoryVC = CreateStoryViewController()
        
        createNewStoryVC.createStorySelected = { [weak self] baseStoryModel in
            print("#### Create story selected callback, showing story detailss")
            if let storyModel = baseStoryModel {
                self?.showStoryDetailsVC(baseStoryModel: storyModel)
            }
        }
        
        navigationController.pushViewController(createNewStoryVC, animated: true)
    }
    
    func showStoryDetailsVC(baseStoryModel: BaseStoryModel) {
        let storyDetailsVC = StoryDetailsViewController()
        let viewModel = StoryDetailsViewModel(baseStoryModel: baseStoryModel, pagesDataSource: [Page](), questionsDataSource: [Question]())
        storyDetailsVC.viewModel = viewModel
        
        storyDetailsVC.reviewPagesSelected = { [weak self] in
            self?.showAllPagesVC(viewModel: viewModel)
        }
        
        storyDetailsVC.reviewTestSelected = { [weak self] in
            self?.showTestVC(viewModel: viewModel)
        }
        
        storyDetailsVC.saveSelected = { [weak self] in
            print("#### TRYING TO SAVE story")
            viewModel.saveStory()
        }
        
        navigationController.pushViewController(storyDetailsVC, animated: true)
    }
    
    func showAllPagesVC(viewModel: StoryDetailsViewModel) {
        let allPagesVC = AllPagesViewController()
        allPagesVC.viewModel = viewModel
        
        allPagesVC.addNewPageSelected = { [weak self] in
            self?.showAddPageVC(viewModel: allPagesVC.viewModel)
        }
        
        navigationController.pushViewController(allPagesVC, animated: true)
    }
    
    private func showTestVC(viewModel: StoryDetailsViewModel) {
        let createTestVC = CreateTestViewController()
        createTestVC.viewModel = viewModel
        
        createTestVC.addQuestionSelected = { [weak self] in
            self?.showAddQuestionVC(viewModel: createTestVC.viewModel)
        }
        
        navigationController.pushViewController(createTestVC, animated: true)
    }
    
    func showAddPageVC(viewModel: StoryDetailsViewModel) {
        let addPageVC = AddPageViewController()
        
        addPageVC.createPageSelected = { [weak self] page in
            print("#### Create page selected, all checks passed. Page -> \(page.audioUUID)")
            viewModel.pagesDataSource.append(page)
            viewModel.reloadPages()
        }
        
        navigationController.pushViewController(addPageVC, animated: true)
    }
    
    func showAddQuestionVC(viewModel: StoryDetailsViewModel) {
        let addQuestionVC = AddQuestionViewController()
        
        addQuestionVC.addQuestionSelected = {  [weak self] question in
            print("#### Create question selected, all checks passed. Question -> \(question.description)")
            viewModel.questionsDataSource.append(question)
            viewModel.reloadQuestions()
        }
        
        navigationController.pushViewController(addQuestionVC, animated: true)
    }
    
}


