//
//  ListeningPhaseStepViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 22.06.22.
//

import UIKit
import AVKit
import AVFoundation

class ListeningPhaseStepViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionImageView: UIImageView!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var playButtonView: UIView!
    @IBOutlet weak var playButtonGradientView: DefaultGradientView!
    @IBOutlet weak var playButtonImageView: UIImageView!
    @IBOutlet weak var playButtonLabel: UILabel!
    
    @IBOutlet weak var nextStepButtonView: UIView!
    @IBOutlet weak var nextStepButtonImageView: UIImageView!
    @IBOutlet weak var nextStepButtonLabel: UILabel!
    
    var audioPlayer: AVAudioPlayer!
    
    var viewModel: PhaseStepViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestures()
        setupUI()
    }
    
    private func setupGestures() {
        let pressToPlayGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPlayButton))
        playButtonView.addGestureRecognizer(pressToPlayGesture)
        
        let nextStepGesture = UITapGestureRecognizer(target: self, action: #selector(didTapNextStepButton))
        nextStepButtonView.addGestureRecognizer(nextStepGesture)
    }
    
    private func setupUI() {
        view.backgroundColor = .iceBlue
        
        headerView.backgroundColor = .white
        headerView.layer.cornerRadius = 16.0
        headerView.clipsToBounds = false
        
        headerImageView.image = UIImage(named: "listeningPhase")
        
        headerLabel.text = viewModel.story?.title
        headerLabel.textColor = .black
        
        closeButton.setBackgroundImage(UIImage(named: "x")?.withRenderingMode(.alwaysTemplate), for: .normal)
        closeButton.tintColor = .black
        
        stepLabel.text = String(format: "Стъпка %d от %d", viewModel.step, viewModel.story?.pages.count ?? 1)
        stepLabel.textColor = .black
        
        if let url = viewModel.story?.pages[viewModel.step - 1].imageDownloadURL {
            questionImageView.af_setImage(withURL: url, cacheKey: nil, placeholderImage: UIImage(named: "library"), serializer: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: false)
        }
        
        questionLabel.text = viewModel.story?.pages[viewModel.step - 1].description
        questionLabel.textColor = .black
        
        questionView.backgroundColor = .white
        questionView.layer.cornerRadius = 16.0
        questionView.clipsToBounds = false
        
        playButtonView.layer.cornerRadius = 16.0
        playButtonGradientView.startColor = .lightRoyalBlue
        playButtonGradientView.endColor = .purpley
        playButtonGradientView.angle = 0
        playButtonGradientView.clipsToBounds = true
        playButtonGradientView.layer.cornerRadius = 16.0
        
        playButtonLabel.text = "Натисни, за да чуеш"
        playButtonLabel.textColor = .white
        playButtonImageView.image = UIImage(named: "volume")
        
        nextStepButtonView.layer.cornerRadius = 16.0
        nextStepButtonView.backgroundColor = .dullPink
        nextStepButtonImageView.image = UIImage(named: "arrowDropRightCircle")
        
        nextStepButtonLabel.text = "Следваща стъпка"
        nextStepButtonLabel.textColor = .white
        
        questionImageView.layer.cornerRadius = 16.0
        
        preparePlayer()
    }
    
    func setStory() {
//        DispatchQueue.main.async {
//            self.headerLabel.text = self.viewModel.story.title
//            self.stepLabel.text = String(format: "Стъпка %d от %d", self.viewModel.step, self.viewModel.story.pages.count)
//            self.questionLabel.text = self.viewModel.story.pages[self.viewModel.step - 1].description
//            self.
//        }
    }
    
    func preparePlayer() {
        guard let url = viewModel.story?.pages[self.viewModel.step - 1].audioDownloadURL else {
            print("Invalid URL")
            return
        }
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playback)
            let soundData = try Data(contentsOf: url)
            audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 0.7
            audioPlayer.delegate = self
            print("#### Finished preparing audio player")
        } catch {
            print(error)
        }
    }
    
    @objc func didTapPlayButton() {
        print("#### Play button pressed")
        audioPlayer.play()
    }
    
    @objc func didTapNextStepButton() {
        print("#### next step button pressed")
        viewModel.nextStepSelected()
    }
    
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        viewModel.closeSelected()
    }
    
    deinit{
        print("#### Deinit called on Listening phase")
    }
}

extension ListeningPhaseStepViewController: AVAudioPlayerDelegate {
    
}
