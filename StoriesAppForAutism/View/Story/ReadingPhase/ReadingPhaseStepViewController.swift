//
//  ReadingPhaseStepViewController.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 22.06.22.
//

import UIKit

class ReadingPhaseStepViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var stepLabel: UILabel!
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var questionTitleLabel: UILabel!
    
    @IBOutlet weak var nextStepButtonView: UIView!
    @IBOutlet weak var nextStepButtonImageView: UIImageView!
    @IBOutlet weak var nextStepButtonLabel: UILabel!
    
    var viewModel: PhaseStepViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestures()
        setupUI()
    }
    
    private func setupGestures() {
        let nextStepGesture = UITapGestureRecognizer(target: self, action: #selector(didTapNextStepButton))
        nextStepButtonView.addGestureRecognizer(nextStepGesture)
    }
    
    private func setupUI() {
        view.backgroundColor = .iceBlue
        
        headerView.backgroundColor = .white
        headerView.layer.cornerRadius = 16.0
        headerView.clipsToBounds = false
        
        headerImageView.image = UIImage(named: "readingPhase")
        
        headerLabel.text = viewModel.story?.title
        headerLabel.textColor = .black
        
        closeButton.setBackgroundImage(UIImage(named: "x")?.withRenderingMode(.alwaysTemplate), for: .normal)
        closeButton.tintColor = .black
        
        stepLabel.text = String(format: "Стъпка %d от %d", viewModel.step, viewModel.story?.pages.count ?? 1)
        stepLabel.textColor = .black
        
        questionTitleLabel.text = viewModel.story?.pages[viewModel.step - 1].description
        questionTitleLabel.textColor = .black
        
        questionView.backgroundColor = .white
        questionView.layer.cornerRadius = 16.0
        questionView.clipsToBounds = false
        
        if let url = viewModel.story?.pages[viewModel.step - 1].imageDownloadURL {
            questionImageView.af_setImage(withURL: url, cacheKey: nil, placeholderImage: UIImage(named: "library"), serializer: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: false)
        }
        
        nextStepButtonView.layer.cornerRadius = 16.0
        nextStepButtonView.backgroundColor = .dullPink
        nextStepButtonImageView.image = UIImage(named: "arrowDropRightCircle")
        
        nextStepButtonLabel.text = "Следваща стъпка"
        nextStepButtonLabel.textColor = .white
        
        questionImageView.layer.cornerRadius = 16.0
    }
    
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        viewModel.closeSelected()
    }
    
    @objc func didTapNextStepButton() {
        print("#### Did tap next button")
        viewModel.nextStepSelected()
    }
    
    deinit{
        print("#### Deinit called on ReadingPhase")
    }
}
