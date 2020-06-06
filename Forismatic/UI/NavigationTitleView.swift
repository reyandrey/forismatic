//
//  NavigationTitleView.swift
//  Forismatic
//
//  Created by Andrey on 06.06.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class NavigationTitleView: UIView {
    
    // MARK: UIView Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: Private
    
    private func setup() {
        addSubview(logoLabel)
        logoLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        logoLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        logoLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private lazy var lineLayer: CAShapeLayer = {
        let line = CAShapeLayer()
        return line
    }()
    
    private lazy var logoLabel: UILabel = {
        let l = UILabel()
        l.text = "forismatic.com"
        l.font = UIFont(name: "Georgia-BoldItalic", size: 21)
        //l.font = UIFont.systemFont(ofSize: 12)
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        l.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        l.widthAnchor.constraint(equalToConstant: 175.0).isActive = true
        return l
    }()
}
