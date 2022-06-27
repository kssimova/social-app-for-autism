//
//  AddQuestionViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 21.06.22.
//

import UIKit
import DropDown

class AddQuestionViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var addQuestionLabel: UILabel!
    @IBOutlet weak var questionTextField: InsetTextField!
    
    @IBOutlet weak var addPhotoOuterView: UIView!
    @IBOutlet weak var addPhotoView: UIView!
    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var addImageLabel: UILabel!
    
    @IBOutlet weak var actualImageView: UIImageView!
    
    @IBOutlet weak var firstAnswerTextField: InsetTextField!
    @IBOutlet weak var secondAnswerTextField: InsetTextField!
    @IBOutlet weak var thirdAnswerTextField: InsetTextField!
    @IBOutlet weak var fourthAnswerTextField: InsetTextField!
    @IBOutlet weak var correctAnswerTextField: InsetTextField!
    
    @IBOutlet weak var wrongInputLabel: UILabel!
    @IBOutlet weak var addQuestionButtonView: UIView!
    @IBOutlet weak var addQuestionButtonLabel: UILabel!
    @IBOutlet weak var addQuestionGradientView: DefaultGradientView!
    
    private var dropDown = DropDown()
    
    var addQuestionSelected : ((Question) -> ()) = { _ in }
    var didUploadImage: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPhotoView(isDefaultHidden: false)
        setupGestures()
        setupUI()
        setupDropDown()
    }
    
    private func setupGestures() {
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        addPhotoOuterView.addGestureRecognizer(imageGesture)
        
        let addQuestionGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAddQuestionButton))
        addQuestionButtonView.addGestureRecognizer(addQuestionGesture)
    }
    
    private func setupUI() {
        view.backgroundColor = .iceBlue
        
        correctAnswerTextField.inputView = UIView()
        correctAnswerTextField.inputAccessoryView = UIView()
        
        questionView.backgroundColor = .white
        questionView.layer.cornerRadius = 16.0
        questionView.clipsToBounds = false
        
        questionImageView.image = UIImage(named: "bigQuestion")
        
        addQuestionLabel.text = "Добавяне на въпрос"
        addQuestionLabel.textColor = .black
        
        addPhotoView.backgroundColor = .veryLightGray
        addPhotoView.layer.cornerRadius = 16.0
        
        addImageLabel.text = "Добавяне на картинка"
        addImageLabel.textColor = .darkerLightGray
        
        actualImageView.isHidden = true
        wrongInputLabel.handleWrongInput(text: nil)
        
        setupTextField(textField: questionTextField, placeholder: "Въпрос")
        setupTextField(textField: firstAnswerTextField, placeholder: "Отговор 1")
        setupTextField(textField: secondAnswerTextField, placeholder: "Отговор 2")
        setupTextField(textField: thirdAnswerTextField, placeholder: "Отговор 3")
        setupTextField(textField: fourthAnswerTextField, placeholder: "Отговор 4")
        setupTextField(textField: correctAnswerTextField, placeholder: "Посочете верен отговор")

        addQuestionButtonView.layer.cornerRadius = 16.0
        addQuestionGradientView.startColor = .lightRoyalBlue
        addQuestionGradientView.endColor = .purpley
        addQuestionGradientView.angle = 0
        addQuestionGradientView.clipsToBounds = true
        addQuestionGradientView.layer.cornerRadius = 16.0
        addQuestionButtonLabel.text = "Добави въпрос"
        addQuestionButtonLabel.textColor = .white
    }
    
    private func setupDropDown() {
        dropDown.anchorView = correctAnswerTextField
        dropDown.dismissMode = .onTap
        dropDown.textFont = UIFont(name: "Poppins-Regular", size: 18.0) ?? UIFont.systemFont(ofSize: 18.0)
        dropDown.bottomOffset = CGPoint(x: 0, y: dropDown.bounds.height + 40)
        dropDown.direction = .any
        dropDown.dataSource = ["Answer 1", "Answer 2", "Answer 3", "Answer 4"]
        dropDown.reloadAllComponents()
        DropDown.appearance().setupCornerRadius(16.0)
        
        dropDown.selectionAction = {(index: Int, item: String) in
            self.correctAnswerTextField.text = item
        }
    }
    
    private func setPhotoView(isDefaultHidden: Bool) {
        addPhotoView.isHidden = isDefaultHidden
        actualImageView.isHidden = !isDefaultHidden
    }
    
    private func setupTextField(textField: UITextField, placeholder: String) {
        textField.delegate = self
        textField.layer.cornerRadius = 14.0
        textField.clipsToBounds = true
        textField.backgroundColor = .veryLightGray
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkerLightGray])
    }
    
    private func checkEmptyFields() {
        print("#### Checking empty text fields in add question...")
        if questionTextField.text?.isEmpty ?? true ||
            firstAnswerTextField.text?.isEmpty ?? true ||
            secondAnswerTextField.text?.isEmpty ?? true ||
            thirdAnswerTextField.text?.isEmpty ?? true ||
            fourthAnswerTextField.text?.isEmpty ?? true ||
            correctAnswerTextField.text?.isEmpty ?? true {
            print("#### Text fields are empty...")
            wrongInputLabel.handleWrongInput(text: "Полетата не трябва да бъдат празни.")
        } else {
            print("#### Text fields are NOT empty, checking image")
            checkImageView()
        }
    }
    
    private func checkImageView() {
        if didUploadImage {
            createQuestionObject()
        } else {
            wrongInputLabel.handleWrongInput(text: "Трябва да качите картинка")
        }
    }
    
    private func createQuestionObject() {
        guard let description = questionTextField.text,
              let image = actualImageView.image,
              let firstAnswer = firstAnswerTextField.text,
              let secondAnswer = secondAnswerTextField.text,
              let thirdAnswer = thirdAnswerTextField.text,
              let fourthAnswer = fourthAnswerTextField.text,
              let correctAnswer = correctAnswerTextField.text else {
            print("#### Something wrong happened!")
            return }
        
        let question = Question(description: description, image: image, answers: [firstAnswer, secondAnswer, thirdAnswer, fourthAnswer], correctAnswer: correctAnswer)
        addQuestionSelected(question)
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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
    
    @objc func didTapAddQuestionButton() {
        checkEmptyFields()
    }
}

extension AddQuestionViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == correctAnswerTextField {
            dropDown.show()
            textField.resignFirstResponder()
        }
    }
}

extension AddQuestionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("#### didFinishPickingMediaWithInfo AddQuestionViewController")
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else { return }

        setPhotoView(isDefaultHidden: true)
        actualImageView.image = image
        actualImageView.layer.cornerRadius = 16.0
        didUploadImage = true
        
        dismiss(animated:true, completion: nil)
    }
}
