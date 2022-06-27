//
//  CreateStoryViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 16.06.22.
//

import UIKit
import DropDown

class CreateStoryViewController: UIViewController {
    @IBOutlet weak var addStoryView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addImageLabel: UILabel!
    @IBOutlet weak var uploadImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var difficultyTextField: InsetTextField!
    @IBOutlet weak var topicTexrField: InsetTextField!
    @IBOutlet weak var ageGroupTextField: InsetTextField!
    
    @IBOutlet weak var wrongInputLabel: UILabel!
    @IBOutlet weak var createStoryButtonView: UIView!
    @IBOutlet weak var createStoryGradientView: DefaultGradientView!
    @IBOutlet weak var createStoryButtonLabel: UILabel!
    
    private var dropDown = DropDown()
    let viewModel = CreateStoryViewModel()
    
    var createStorySelected : ((BaseStoryModel?) -> ()) = { _ in }
    
    var didUploadImage: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestures()
        setupUI()
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCreateNewStoryButton))
        createStoryButtonView.addGestureRecognizer(tapGesture)
        
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        uploadImageView.addGestureRecognizer(imageGesture)
    }
    
    private func setupUI() {
        view.backgroundColor = .iceBlue
        
        addStoryView.backgroundColor = .white
        addStoryView.layer.cornerRadius = 16.0
        addStoryView.clipsToBounds = false
        
        uploadImageView.image = UIImage(named: "uploadPhoto")
        uploadImageView.isUserInteractionEnabled = true
        
        addImageLabel.text = "Добавяне на снимка на историята"
        addImageLabel.textColor = .black
        
        wrongInputLabel.handleWrongInput(text: nil)
        
        setupTextField(textField: titleTextField, placeholder: "Заглавие")
        setupTextField(textField: descriptionTextField, placeholder: "Описание")
        setupTextField(textField: difficultyTextField, placeholder: "Ниво на трудност")
        setupTextField(textField: topicTexrField, placeholder: "Тема")
        setupTextField(textField: ageGroupTextField, placeholder: "Възрастова група")
        
        setupDropDownTextField(textField: difficultyTextField)
        setupDropDownTextField(textField: topicTexrField)
        setupDropDownTextField(textField: ageGroupTextField)
        
        setupDropDown()
        
        createStoryButtonView.layer.cornerRadius = 16.0
        createStoryGradientView.startColor = .lightRoyalBlue
        createStoryGradientView.endColor = .purpley
        createStoryGradientView.angle = 0
        createStoryGradientView.clipsToBounds = true
        createStoryGradientView.layer.cornerRadius = 16.0
        createStoryButtonLabel.text = "Създаване на история"
        createStoryButtonLabel.textColor = .white
    }
    
    private func setupTextField(textField: UITextField, placeholder: String) {
        textField.delegate = self
        textField.layer.cornerRadius = 16.0
        textField.clipsToBounds = true
        textField.backgroundColor = .veryLightGray
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkerLightGray])
    }
    
    private func setupDropDownTextField(textField: UITextField) {
        textField.inputView = UIView()
        textField.inputAccessoryView = UIView()
    }
    
    private func setupDropDown() {
        dropDown.anchorView = difficultyTextField
        dropDown.dismissMode = .onTap
        dropDown.textFont = UIFont(name: "Poppins-Regular", size: 18.0) ?? UIFont.systemFont(ofSize: 18.0)
        dropDown.bottomOffset = CGPoint(x: 0, y: dropDown.bounds.height + 40)
        dropDown.direction = .any
        dropDown.dataSource = viewModel.difficulyLevelDataSource
        dropDown.reloadAllComponents()
        DropDown.appearance().setupCornerRadius(16.0)
    }
    
    private func setCustomDropDown(textField: UITextField, dataSource: [String]) {
        dropDown.anchorView = textField
        dropDown.dataSource = dataSource
        dropDown.reloadAllComponents()
        
        dropDown.selectionAction = {(index: Int, item: String) in
            textField.text = item
        }
    }
    
    private func handleTextFieldDropDown(_ textField: UITextField) {
        switch textField {
        case difficultyTextField:
            setCustomDropDown(textField: difficultyTextField, dataSource: viewModel.difficulyLevelDataSource)
            textField.resignFirstResponder()
            dropDown.show()
        case topicTexrField:
            setCustomDropDown(textField: topicTexrField, dataSource: viewModel.topicDataSource)
            textField.resignFirstResponder()
            dropDown.show()
        case ageGroupTextField:
            setCustomDropDown(textField: ageGroupTextField, dataSource: viewModel.ageGroupDataSource)
            textField.resignFirstResponder()
            dropDown.show()
        default:
            break
        }
    }
    
    private func checkEmptyFields() {
        print("#### Checking empty text fields in create story...")
        if titleTextField.text?.isEmpty ?? true ||
            descriptionTextField.text?.isEmpty ?? true ||
            difficultyTextField.text?.isEmpty ?? true ||
            topicTexrField.text?.isEmpty ?? true ||
            ageGroupTextField.text?.isEmpty ?? true {
            print("#### Text fields are empty...")
            wrongInputLabel.handleWrongInput(text: "Полетата не трябва да бъдат празни.")
        } else {
            print("#### Text fields are NOT empty, setting base story model")
            checkImage()
        }
    }
    
    private func checkImage() {
        if didUploadImage {
            createStoryObject()
        } else {
            wrongInputLabel.handleWrongInput(text: "Трябва да качите картинка")
        }
    }
    
    private func createStoryObject() {
        viewModel.baseStoryModel = BaseStoryModel(coverImage: uploadImageView.image,
                                                  title: titleTextField.text,
                                                  description: descriptionTextField.text,
                                                  difficultyLevel: difficultyTextField.text,
                                                  topic: topicTexrField.text,
                                                  ageGroup: ageGroupTextField.text)
        
        navigationController?.popViewController(animated: true)
        createStorySelected(viewModel.baseStoryModel)
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapCreateNewStoryButton() {
        checkEmptyFields()
    }
    
    @objc func didTapImageView() {
        print("#### Tap on image view")
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
}

extension CreateStoryViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        handleTextFieldDropDown(textField)
    }
}

extension CreateStoryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("#### didFinishPickingMediaWithInfo")
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else { return }

        uploadImageView.image = image
        uploadImageView.layer.cornerRadius = 16.0
        didUploadImage = true
        
        dismiss(animated:true, completion: nil)
    }
}
