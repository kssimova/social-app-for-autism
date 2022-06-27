//
//  AddPageViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 17.06.22.
//

import UIKit
import AVFoundation

class AddPageViewController: UIViewController {
    @IBOutlet weak var addPageView: UIView!
    @IBOutlet weak var backButton: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionTextField: InsetTextField!
    
    @IBOutlet weak var addPhotoView: UIView!
    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var addImageLabel: UILabel!
    
    @IBOutlet weak var audioImageView: UIImageView!
    @IBOutlet weak var audioLabel: UILabel!
    @IBOutlet weak var soundWaveStackView: UIStackView!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var wrongInputLabel: UILabel!
    @IBOutlet weak var createPageButtonView: UIView!
    @IBOutlet weak var createPageGradientView: DefaultGradientView!
    @IBOutlet weak var createPageButtonLabel: UILabel!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    private var meterTimer: Timer! = nil
    private var currentTimeInterval: TimeInterval = 0.0
    
    let audioUUID = UUID().uuidString
    var audioFilename: URL!
    
    var hasRecordedAudio: Bool = false
    
    var viewModel: StoryDetailsViewModel!
    
    var exportOutputURL: URL? {
        let pathURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        print("#### Exported url is \(pathURL?.appendingPathComponent(audioUUID))")
        return pathURL?.appendingPathComponent(audioUUID)
    }
    
    var createPageSelected : ((Page) -> ()) = { _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestures()
        setupUI()
        setupAudio()
    }
    
    private func setupGestures() {
        let newPageTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAddNewPageButton))
        createPageButtonView.addGestureRecognizer(newPageTapGesture)
        
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        addPhotoView.addGestureRecognizer(imageGesture)
        
        let recordGesture = UITapGestureRecognizer(target: self, action: #selector(didTapRecord))
        audioImageView.addGestureRecognizer(recordGesture)
        audioImageView.isUserInteractionEnabled = true
    }
    
    private func setupUI() {
        view.backgroundColor = .iceBlue
        
        addPageView.backgroundColor = .white
        addPageView.layer.cornerRadius = 16.0
        addPageView.clipsToBounds = false
                
        titleLabel.textColor = .black
        titleLabel.text = "Добавяне на страница"
        
        wrongInputLabel.handleWrongInput(text: nil)
        
        descriptionTextField.layer.cornerRadius = 16.0
        descriptionTextField.delegate = self
        descriptionTextField.clipsToBounds = true
        descriptionTextField.backgroundColor = .veryLightGray
        descriptionTextField.textColor = .black
        descriptionTextField.attributedPlaceholder = NSAttributedString(string: "Описание", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkerLightGray])
        
        addPhotoView.backgroundColor = .veryLightGray
        addPhotoView.layer.cornerRadius = 16.0
        addPhotoView.clipsToBounds = false
        addImageView.image = UIImage(named: "addPhoto")
        
        addImageLabel.textColor = .lightGray
        addImageLabel.text = "Добавяне на картинка"
        
        audioImageView.image = UIImage(named: "audio")
        audioLabel.textColor = .lightGray
        audioLabel.text = "Задръж да запишеш аудио файл"
        
        createPageButtonView.layer.cornerRadius = 16.0
        createPageGradientView.startColor = .lightRoyalBlue
        createPageGradientView.endColor = .purpley
        createPageGradientView.angle = 0
        createPageGradientView.clipsToBounds = true
        createPageGradientView.layer.cornerRadius = 16.0
        createPageButtonLabel.text = "Създаване на нова страница"
        createPageButtonLabel.textColor = .white
    }
    
    private func setAudioRecordingView(isRecording: Bool) {
        print("#### Setting up audio recording view, isRecording -> \(isRecording)")
        audioLabel.isHidden = isRecording
        soundWaveStackView.isHidden = !isRecording
    }
    
    private func checkEmptyFields() {
        if descriptionTextField.text?.isEmpty ?? true {
            wrongInputLabel.handleWrongInput(text: "Описанието не трябва да е празно.")
        } else {
            if addImageView.image == UIImage(named: "addPhoto") {
                wrongInputLabel.handleWrongInput(text: "Трябва да добавите картинка.")
            } else {
                if !hasRecordedAudio {
                    wrongInputLabel.handleWrongInput(text: "Трябва да запишете аудио.")
                } else {
                    createPageObject()
                }
            }
        }
    }
    
    private func createPageObject() {
        guard let description = descriptionTextField.text,
              let image = addImageView.image,
              let data = try? Data(contentsOf: audioFilename) else {
            print("#### Something wrong happened!")
            return }
        
        let page = Page(description: description, image: image, audioData: data, audioUUID: audioUUID)
        createPageSelected(page)
        
        navigationController?.popViewController(animated: true)
    }
    
    private func setupAudio() {
        // Create path to audio file that will be recorded
        audioFilename = getDocumentsDirectory().appendingPathComponent("\(audioUUID).m4a")
        recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            // Reqeust permission for microphone access
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.setAudioRecordingView(isRecording: true)
                    } else {
                        // failed to record!
                        self.wrongInputLabel.handleWrongInput(text: "Възникна грешка при записването на аудио!")
                    }
                }
            }
        } catch {
            // failed to record!
            wrongInputLabel.handleWrongInput(text: "Възникна грешка при записването на аудио!")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func startRecording() {
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            

            setAudioRecordingView(isRecording: true)
            meterTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateAudioTimer(timer:)), userInfo: nil, repeats: true)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        meterTimer?.invalidate()
        meterTimer = nil
        
        setAudioRecordingView(isRecording: false)

        if success {
            hasRecordedAudio = true
            audioLabel.text = "Аудио файл е добавен. Тапни, за да запишеш отново"
        } else {
            // recording failed :(
            hasRecordedAudio = false
            wrongInputLabel.handleWrongInput(text: "Възникна грешка при записването на аудио!")
        }
    }
    
    func export(fileType: AVFileType = .m4a, completion: @escaping (() -> Void)) {
        let asset = AVAsset(url: audioFilename)
        guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A) else { return }
        exportSession.outputFileType = fileType
        exportSession.metadata = asset.metadata
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.outputURL = exportOutputURL
        exportSession.exportAsynchronously {
            completion()
        }
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapAddNewPageButton() {
        checkEmptyFields()
    }
    
    @objc func didTapImageView() {
        print("#### Tap on image view in AddPageViewController")
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func didTapRecord() {
        print("#### Record tapped, audio recorder -> \(audioRecorder)")
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    @objc private func updateAudioTimer(timer: Timer) {
        print("#### Updating audio timer")
        if audioRecorder.isRecording {
            currentTimeInterval = currentTimeInterval + 1
            let min = Int(currentTimeInterval / 60)
            let sec = Int(currentTimeInterval.truncatingRemainder(dividingBy: 60))
            let totalTimeString = String(format: "%02d:%02d", min, sec)
            print("#### Audio is recording total time -> \(totalTimeString)")
            timerLabel.text = totalTimeString
        }
    }
}

extension AddPageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("#### didFinishPickingMediaWithInfo in AddPageViewController")
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else { return }

        addImageView.image = image
        addImageView.layer.cornerRadius = 16.0
        
        dismiss(animated:true, completion: nil)
    }
}

extension AddPageViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}

extension AddPageViewController: UITextFieldDelegate {
    
}
