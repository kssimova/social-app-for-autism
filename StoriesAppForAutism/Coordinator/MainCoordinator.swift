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
            self?.showLibraryVC()
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
    
    func showLibraryVC() {
        let libraryVC = StoryLibraryViewController()
        
        libraryVC.createNewStorySelected = { [weak self] in
            self?.showCreateNewStoryVC()
        }
        
        navigationController.pushViewController(libraryVC, animated: true)
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


