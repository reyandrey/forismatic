//
//  ViewController.swift
//  RequestManager
//
//  Created by Andrey on 30.05.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

protocol QuoteViewControllerDelegate: class {
    func controller(_ controller: QuoteViewController, shouldOpenURL url: URL)
}
class QuoteViewController: UIViewController, Storyboardable {
    typealias T = QuoteViewController
    static var storyboardName: String { return "Quote" }

    private let timer: QuoteTimer = QuoteTimer()
    weak var delegate: QuoteViewControllerDelegate?
    var viewModel: QuoteViewModel!
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var progressView: StoryIndicatorView!
    @IBOutlet private weak var quoteDimmingView: UIView!
    @IBOutlet private weak var quoteTextLabel: UILabel!
    @IBOutlet private weak var quoteAuthorLabel: UILabel!
    @IBOutlet private weak var linkButton: UIButton!
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            setup()
            bindViewModel()
            viewModel.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        quoteDimmingView.addShadow(withColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), opacity: 0.5, radius: 20, xOffset: 0, yOffset: 0)
    }


}

//MARK: ViewModel

extension QuoteViewController {
    
    func bindViewModel() {
        viewModel.didUpdate = { [weak self] viewModel in
            self?.didUpdate(viewModel)
        }
    }
    
    func didUpdate(_ viewModel: QuoteViewModel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + (viewModel.isUpdating ? 0:0.33)) { [weak self] in
            //self?.title = viewModel.title
            viewModel.isUpdating ? self?.setUpdating() : self?.setUpdated()
        }
        
    }
}

//MARK: Private

extension QuoteViewController {
    
    @available(iOS 13.0, *)
    func setup() {
        linkButton.isHidden = true
        linkButton.addTarget(self, action: #selector(quoteLinkDidTap(_:)), for: .touchUpInside)
        quoteDimmingView.alpha = 0
        let image = UIImage(systemName: "pause.fill", withConfiguration: nil)
        let playPauseButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(pauseDidTap(_:)))
        playPauseButton.tintColor = .white
        navigationItem.setRightBarButton(playPauseButton, animated: false)
        
        timer.didCountdown = { [weak self] in
            self?.viewModel.reloadData()
        }
        timer.didUpdateProgress = { [weak self] progress in
            self?.timerDidUpdateProgress(progress)
        }
        
    }
    
    func setUpdating() {
        timer.reset()
        UIView.animate(withDuration: 0.33) {
            self.quoteDimmingView.alpha = 0
        }
    }
    
    func setUpdated() {
        quoteTextLabel.text = viewModel.quoteText
        quoteAuthorLabel.text = viewModel.quoteAuthor
        linkButton.isHidden = viewModel.quoteLink == nil
        UIView.animate(withDuration: 0.33) {
            self.quoteDimmingView.alpha = 1
        }
        timer.start()
    }
    
    func timerDidUpdateProgress(_ progress: CGFloat) {
        progressView.fillPercentValue = progress
    }
    
    
    @available(iOS 13.0, *)
    @objc func pauseDidTap(_ sender: Any) {
        timer.onPause = !timer.onPause
        let playImage = UIImage(systemName: "play.fill", withConfiguration: nil)
        let pauseImage = UIImage(systemName: "pause.fill", withConfiguration: nil)
        navigationItem.rightBarButtonItem?.image = timer.onPause ?  playImage : pauseImage
    }
    
    @objc func quoteLinkDidTap(_ sender: Any) {
        guard let urlString = viewModel.quoteLink, let url = URL(string: urlString) else { return }
        delegate?.controller(self, shouldOpenURL: url)
    }
}
