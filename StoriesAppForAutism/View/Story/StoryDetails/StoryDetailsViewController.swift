//
//  StoryDetailsViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 17.06.22.
//

import UIKit

class StoryDetailsViewController: UIViewController {
    @IBOutlet weak var storyDetailsView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var storyDetailsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var ageGroupLabel: UILabel!
    
    @IBOutlet weak var reviewPagesButtonView: UIView!
    @IBOutlet weak var reviewPagesGradientButtonView: DefaultGradientView!
    @IBOutlet weak var reviewPagesButtonLabel: UILabel!

    @IBOutlet weak var reviewTestButtonView: UIView!
    @IBOutlet weak var reviewTestButtonGradientView: DefaultGradientView!
    @IBOutlet weak var reviewTestButtonLabel: UILabel!
    
    @IBOutlet weak var saveStoryButtonView: UIView!
    @IBOutlet weak var saveStoryGradientView: DefaultGradientView!
    @IBOutlet weak var saveStoryButtonLabel: UILabel!
    
    var reviewPagesSelected : (() -> ()) = { }
    var reviewTestSelected : (() -> ()) = { }
    var saveSelected : (() -> ()) = { }
    
    var viewModel: StoryDetailsViewModel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestures()
        setupUI()
    }
    
    private func setupGestures() {
        let reviewPagesGesture = UITapGestureRecognizer(target: self, action: #selector(didTapReviewPagesButton))
        reviewPagesButtonView.addGestureRecognizer(reviewPagesGesture)
        
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        storyDetailsImageView.addGestureRecognizer(imageGesture)
        
        let reviewTestGesture = UITapGestureRecognizer(target: self, action: #selector(didTapReviewTestButton))
        reviewTestButtonView.addGestureRecognizer(reviewTestGesture)
        
        let saveGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSaveButton))
        saveStoryButtonView.addGestureRecognizer(saveGesture)
    }
    
    private func setupUI() {
        view.backgroundColor = .iceBlue
        
        storyDetailsView.backgroundColor = .white
        storyDetailsView.layer.cornerRadius = 16.0
        storyDetailsView.clipsToBounds = false
        
        storyDetailsImageView.image = viewModel.baseStoryModel.coverImage
        
        titleLabel.textColor = .black
        titleLabel.text = viewModel.baseStoryModel.title
        topicLabel.textColor = .grayishBrown
        topicLabel.text = viewModel.baseStoryModel.topic
        ageGroupLabel.textColor = .indigoBlue
        ageGroupLabel.text = viewModel.baseStoryModel.ageGroup
        
        reviewPagesButtonView.layer.cornerRadius = 16.0
        reviewPagesGradientButtonView.startColor = .lightRoyalBlue
        reviewPagesGradientButtonView.endColor = .purpley
        reviewPagesGradientButtonView.angle = 0
        reviewPagesGradientButtonView.clipsToBounds = true
        reviewPagesGradientButtonView.layer.cornerRadius = 16.0
        reviewPagesButtonLabel.text = "Преглед на страници"
        reviewPagesButtonLabel.textColor = .white
        
        reviewTestButtonView.layer.cornerRadius = 16.0
        reviewTestButtonGradientView.startColor = .dullPink
        reviewTestButtonGradientView.endColor = .dullPink
        reviewTestButtonGradientView.angle = 0
        reviewTestButtonGradientView.clipsToBounds = true
        reviewTestButtonGradientView.layer.cornerRadius = 16.0
        reviewTestButtonLabel.text = "Преглед на тест"
        reviewTestButtonLabel.textColor = .white
        
        saveStoryButtonView.layer.cornerRadius = 16.0
        saveStoryGradientView.startColor = .purpley
        saveStoryGradientView.endColor = .lightRoyalBlue
        saveStoryGradientView.angle = 0
        saveStoryGradientView.clipsToBounds = true
        saveStoryGradientView.layer.cornerRadius = 16.0
        saveStoryButtonLabel.text = "Запази история"
        saveStoryButtonLabel.textColor = .white
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapReviewPagesButton() {
        reviewPagesSelected()
    }
    
    @objc func didTapImageView() {
        print("#### Tap on image view in story details")
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func didTapReviewTestButton() {
        reviewTestSelected()
    }
    
    @objc func didTapSaveButton() {
        print("#### Tapping save button")
        saveSelected()
    }
    
}

extension StoryDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("#### didFinishPickingMediaWithInfo")
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else { return }

        storyDetailsImageView.image = image
        storyDetailsImageView.layer.cornerRadius = 16.0
        
        dismiss(animated:true, completion: nil)
    }
}
