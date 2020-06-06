//
//  ViewController.swift
//  RequestManager
//
//  Created by Andrey on 30.05.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class QuoteViewController: UIViewController, Storyboardable {
    typealias T = QuoteViewController
    static var storyboardName: String { return "Quote" }

    var viewModel: QuoteViewModel!
    
    @IBOutlet private weak var quoteDimmingView: UIView!
    @IBOutlet private weak var quoteTextLabel: UILabel!
    @IBOutlet private weak var quoteAuthorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewModel()
        viewModel.reloadData()
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
            self?.title = viewModel.title
            viewModel.isUpdating ? self?.setUpdating() : self?.setUpdated()
        }
        
    }
}

//MARK: Private

extension QuoteViewController {
    func setup() {
        quoteDimmingView.alpha = 0
        quoteDimmingView.isUserInteractionEnabled = true
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(quoteViewDidTap(_:)))
        quoteDimmingView.addGestureRecognizer(tapGR)
    }
    
    func setUpdating() {
        UIView.animate(withDuration: 0.33) {
            self.quoteDimmingView.alpha = 0
        }
    }
    func setUpdated() {
        quoteTextLabel.text = viewModel.quoteText
        quoteAuthorLabel.text = viewModel.quoteAuthor
        UIView.animate(withDuration: 0.33) {
            self.quoteDimmingView.alpha = 1
        }
    }
    
    @objc func quoteViewDidTap(_ sender: Any) {
        viewModel.reloadData()
    }
}
